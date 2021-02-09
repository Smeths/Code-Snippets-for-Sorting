@echo off
for %%m in (base, DM, DS) do (
    for %%y in (2028, 2043, 2058) do (
        for %%t in (AM, IP, PM) do (
            call extract_txt2 "%%m" "%%t" "%%y"
        )
    )
)
pause