////////////////////////////////////////////////////////////////////////////////
// Created: 06.01.2025
// Author: Deathman
// Nocturning studio for NS Project X
////////////////////////////////////////////////////////////////////////////////
#include "common.xrh"
#include "skinning.xrh"
////////////////////////////////////////////////////////////////////////////////
struct Interpolators
{
    float4 HomogeniousPosition : POSITION;
    float3 Position : TEXCOORD0;
    float2 UV : TEXCOORD1;
};
////////////////////////////////////////////////////////////////////////////////
Interpolators _main(v_model Input)
{
    Interpolators Output;
    
    Output.HomogeniousPosition = mul(m_WVP, Input.P);
    Output.Position = mul(m_WV, Input.P);
    Output.UV = Input.tc;
    
    return Output;
}
////////////////////////////////////////////////////////////////////////////////
#ifdef SKIN_NONE
Interpolators main(v_model v) { return _main(v); }
#endif

#ifdef SKIN_0
Interpolators main(v_model_skinned_0 v) { return _main(skinning_0(v)); }
#endif

#ifdef SKIN_1
Interpolators main(v_model_skinned_1 v) { return _main(skinning_1(v)); }
#endif

#ifdef SKIN_2
Interpolators main(v_model_skinned_2 v) { return _main(skinning_2(v)); }
#endif
////////////////////////////////////////////////////////////////////////////////
