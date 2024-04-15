transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/BitwiseNot.v}
vlog -vlog01compat -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/HalfAdder.v}
vlog -vlog01compat -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/FullAdder.v}
vlog -vlog01compat -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Subtractor.v}
vlog -vlog01compat -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Adder.v}

vlog -vlog01compat -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/ALU_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  ALU_tb

add wave *
view structure
view signals
run -all
