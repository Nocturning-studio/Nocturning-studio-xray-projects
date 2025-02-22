#include "common.xrh"

struct v_vert
{
	float4 pos: POSITION; // (float,float,float,1)
	float4 color: COLOR0; // (r,g,b,dir-occlusion)
};
struct vf
{
	float4 hpos: POSITION;
	float4 c: COLOR0;
};

vf main (v_vert v)
{
    vf o;

    o.hpos = mul (m_VP, v.pos); // xform, input in world coords
    o.c = v.color;

    return o;
}

