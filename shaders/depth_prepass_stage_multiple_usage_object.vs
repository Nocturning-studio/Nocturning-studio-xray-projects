////////////////////////////////////////////////////////////////////////////////
// Created: 06.01.2025
// Author: Deathman
// Nocturning studio for NS Project X
////////////////////////////////////////////////////////////////////////////////
#include "common.xrh"
////////////////////////////////////////////////////////////////////////////////
struct VertexData
{
    float4 Position : POSITION;
    float4 UV : TEXCOORD0;
};
////////////////////////////////////////////////////////////////////////////////
struct Interpolators
{
    float4 HomogeniousPosition : POSITION;
    float2 UV : TEXCOORD0;
    float3 Position : TEXCOORD1;
};
////////////////////////////////////////////////////////////////////////////////
Interpolators main(VertexData Input)
{
    Interpolators Output;

    float3 pos = mul(m_xform, Input.Position);
    
    float2 result = 0.0f;
    
#ifdef USE_TREEWAVE
	float base = m_xform._24;								// take base height from matrix
	float dp = calc_cyclic(wave.w+dot(pos, (float3)wave));
	float H = pos.y - base;									// height of vertex (scaled, rotated, etc.)
	float frac = Input.UV.z * consts.x;						// fractional (or rigidity)
	float inten = H * dp;									// intensity
	float2 result = calc_xz_wave(wind.xz * inten, frac);
#endif

    float4 w_pos = float4(pos.x + result.x, pos.y, pos.z + result.y, 1.0f);

    Output.HomogeniousPosition = mul(m_VP, w_pos);
    Output.Position = mul(m_V, w_pos);
    Output.UV = (Input.UV * consts).xy;
    
    return Output;
}
////////////////////////////////////////////////////////////////////////////////
