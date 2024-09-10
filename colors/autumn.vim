lua << EOF
if vim.g.autumn_debug then
  require("autumn.reload")() 
end

require("autumn.config").set_style("autumn")
require("autumn").load()
EOF
