function normal		(shader, t_base, t_second, t_detail)
	shader:begin	("null","distort")
			: fog	(false)
			: zb 	(false,false)
	shader:sampler	("s_base")	:texture("$user$generic0")	: clamp() : f_anisotropic() : srgb()
	shader:sampler	("s_distort")  	:texture("$user$distortion") : clamp() : f_linear ()
end
