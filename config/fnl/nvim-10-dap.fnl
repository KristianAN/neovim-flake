(let [dap (require :dap)]
  dap.configurations.scala
  {{:metals {:runType :runOrTestFile}
     :name :RunOrTest
     :request :launch
     :type :scala} {:type :scala
                                                                                                      :request :launch
                                                                                                      :name "Test Target"
                                                                                                      :metals {:runType :testTarget}}})

; dap.configurations.java = {
;   {
;     type = 'java',
;     request = 'attach',
;     name = "Debug (Attach) - Remote",
;     hostName = "127.0.0.1",
;     port = 8000,
;   },
; }
;
; vim.keymap.set('n', '<leader>dd',
;   function() dap.toggle_breakpoint() end
;   , { desc = 'Toggle breakpoint' })
;
; vim.keymap.set('n', '<leader>du', function()
;   require 'dapui'.open()
; end, { desc = 'Debug' })
;
; vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = "Start/continue debugging" })
;

(let [dapui (require :dapui)]
  (dapui.setup))

