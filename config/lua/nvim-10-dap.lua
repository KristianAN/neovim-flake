-- [nfnl] Compiled from nvim-10-dap.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local dap = require("dap")
  dap.configurations.scala({[{metals = {runType = "runOrTestFile"}, name = "RunOrTest", request = "launch", type = "scala"}] = {type = "scala", request = "launch", metals = {runType = "testTarget"}}})
end
local dapui = require("dapui")
return dapui.setup()
