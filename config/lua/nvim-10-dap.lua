-- [nfnl] Compiled from nvim-10-dap.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local dap = require("dap")
  do local _ = dap.configurations.scala end
  do local _ = {[{metals = {runType = "runOrTestFile"}, name = "RunOrTest", request = "launch", type = "scala"}] = {type = "scala", request = "launch", name = "Test Target", metals = {runType = "testTarget"}}} end
end
local dapui = require("dapui")
return dapui.setup()
