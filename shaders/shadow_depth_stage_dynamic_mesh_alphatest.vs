#include "common.xrh"
#include "skinning.xrh"
//////////////////////////////////////////////////////////////////////////////////////////
// Vertex
v_shadow_direct_aref _main (v_model I)
{
    v_shadow_direct_aref O;
    float4 hpos = mul (m_WVP, I.P);
    O.hpos = hpos;
    O.tc0 = I.tc;
    return O;
}

/////////////////////////////////////////////////////////////////////////
#ifdef 	SKIN_NONE
v_shadow_direct_aref 	main(v_model v) 		{ return _main(v); 		}
#endif

#ifdef 	SKIN_0
v_shadow_direct_aref 	main(v_model_skinned_0 v) 	{ return _main(skinning_0(v)); }
#endif

#ifdef	SKIN_1
v_shadow_direct_aref 	main(v_model_skinned_1 v) 	{ return _main(skinning_1(v)); }
#endif

#ifdef	SKIN_2
v_shadow_direct_aref 	main(v_model_skinned_2 v) 	{ return _main(skinning_2(v)); }
#endif


