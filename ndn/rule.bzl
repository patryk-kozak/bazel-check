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
# - analizer and parser for outputs
# -- provide as tool to rule
# -- python/go probably, easiest to do in Java

print('<< >> evaluation init')

def _impl(ctx):

    args = [ctx.attr.targets]

    ctx.actions.run(
        inputs = [],
        outputs = [ctx.outputs.executable],
        arguments = args,
        executable = ctx.executable._exec,
        use_default_shell_env = True,
    )
    
    return [DefaultInfo(executable = ctx.outputs.executable)]

ndn = rule(
    implementation = _impl,
    attrs = {
        "targets": attr.string(
            mandatory = True,
        ),
        "_exec": attr.label(
            default = "@bazel_ndn//ndn:exec",
            executable = True,
            cfg = "exec",
        )
        # "_template": attr.label(
        #     default = "report_template",
        #     allow_single_file = True
        # )
    },
    executable = True,
)
