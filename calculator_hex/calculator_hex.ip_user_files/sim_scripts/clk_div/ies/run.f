-makelib ies_lib/xil_defaultlib -sv \
  "D:/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../calculator_hex.srcs/sources_1/ip/clk_div/clk_div_clk_wiz.v" \
  "../../../../calculator_hex.srcs/sources_1/ip/clk_div/clk_div.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

