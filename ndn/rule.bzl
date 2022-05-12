# TODO
# 1. Create seperate output / use existing - reusing output that exists for first run is probably best, save times.
# 2. Run build on the specified targets
# 3. Collect data from first run
# 4. Clean output / create seperate output for next build
# 5. Re-run build for same targets
# 6. Collect data from second run
# 7. Parse both outputs
# 8. Compare the outputs SHA's
# 9. List all SHA's / CAS that are different between runs

# X. Generate report

# Questions:
# - how to get outputs of runs, experimental execution log?
# -- skylib to read file?
# -- plain sh ?
# - analizer and parser for outputs
# -- provide as tool to rule
# -- python/go probably, easiest to do in Java for me tho, but python easy mode as well

load(
    "@bazel_skylib//lib:shell.bzl",
    "shell",
)

def _impl(ctx):
    sh_file = ctx.actions.declare_file(ctx.label.name + ".sh")
    log_file = ctx.actions.declare_file(ctx.label.name + ".log")
    rerun_file = ctx.actions.declare_file(ctx.label.name + ".rerun.log")

    substitutions = {
        "#TARGETS#": shell.quote(ctx.attr.targets),
    }

    ctx.actions.expand_template(
        template = ctx.file._template,
        output = sh_file,
        substitutions = substitutions,
        is_executable = True,
    )

    print("Run shell")
    ctx.actions.run_shell(
        outputs = [log_file, rerun_file],
        inputs = [sh_file],
        command = "%s %s %s" % (sh_file.path, log_file.path, rerun_file.path),
        use_default_shell_env = True,
    )
    print("After run shell")

    runfiles = ctx.runfiles(files = [
        sh_file,
        log_file,
        rerun_file
    ])

    return [DefaultInfo(
        executable = sh_file,
        runfiles = runfiles
    )]

_ndn_prepare = rule(
    implementation = _impl,
    attrs = {
        "targets": attr.string(
            mandatory = True,
        ),
        "_exec": attr.label(
            default = "@bazel_ndn//ndn:exec",
            executable = True,
            cfg = "exec",
        ),
        "_template": attr.label(
            default = "@bazel_ndn//ndn:bzl_cmd.exec.sh.in",
            allow_single_file = True
        ),
    },
    executable = True,
)

def ndn(name, targets):

    prepare_name = name + "_prepare"
    _ndn_prepare(
        name = prepare_name,
        targets = targets,
    )

    # diff run in python
    # analyzer run in python

    execlog_parser_name = "execlog_parser_" + name
    native.genrule(
        name = name,
        srcs = [
            prepare_name
        ],
        outs = [execlog_parser_name + ".parsed"],
        executable = True,
        tools = ["@io_bazel//src/tools/execlog:parser"],
        cmd = "$(location @io_bazel//src/tools/execlog:parser) --log_path $(SRCS) --output_path test",
    )