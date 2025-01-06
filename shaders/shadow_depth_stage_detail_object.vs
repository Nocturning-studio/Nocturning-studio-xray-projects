////////////////////////////////////////////////////////////////////////////////
// Created: 06.01.2025
// Author: Deathman
// Nocturning studio for NS Project X
////////////////////////////////////////////////////////////////////////////////
#include "common.xrh"
///////////////////////////////////////////////////////////////////////////////////
struct VertexData
{
    float4 Position : POSITION;
    int4 Misc : TEXCOORD0;
};
///////////////////////////////////////////////////////////////////////////////////
struct Interpolators
{
    float4 HomogeniousPosition : POSITION;
    float3 Position : TEXCOORD0;
    float2 UV : TEXCOORD4;
};
///////////////////////////////////////////////////////////////////////////////////
uniform float4 dir2D;
uniform float4 array[200] : register(c12);
///////////////////////////////////////////////////////////////////////////////////
Interpolators main(VertexData Input)
{
    Interpolators Output;

	// index
    int i = Input.Misc.w;
    float4 m0 = array[i + 0];
    float4 m1 = array[i + 1];
    float4 m2 = array[i + 2];
    float4 c0 = array[i + 3];

	// Transform pos to world coords
    float4 pos;
    pos.x = dot(m0, Input.Position);
    pos.y = dot(m1, Input.Position);
    pos.z = dot(m2, Input.Position);
    pos.w = 1.0f;

    float2 result = float2(0, 0);
    
#ifdef USE_DETAILWAVE
    float base = m1.w;
    float dp = calc_cyclic (dot (pos, wave));
    float H = pos.y - base; // height of vertex (scaled)
    float frac = Input.Misc.z * consts.x; // fractional
    float inten = H * dp;
	result = calc_xz_wave (dir2D.xz * inten, frac);
#endif
    
    pos = float4(pos.x + result.x, pos.y, pos.z + result.y, 1.0f);
    
    Output.HomogeniousPosition = mul(m_WVP, pos);
    Output.Position = mul(m_WV, pos);
    Output.UV = Input.Misc.xy * consts.xy;

    return Output;
}
///////////////////////////////////////////////////////////////////////////////////