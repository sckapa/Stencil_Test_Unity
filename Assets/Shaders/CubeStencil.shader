Shader "Custom/CubeStencil"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Geometry" }
        Pass
        {
            // Enable stencil buffer
            Stencil
            {
                Ref 1
                Comp always
                Pass replace
            }

            // Disable color writes
            ColorMask 0

            // Disable depth writes
            ZWrite Off

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
            };

            Varyings vert (Attributes input)
            {
                Varyings output;
                output.positionHCS = TransformObjectToHClip(input.positionOS);
                return output;
            }

            half4 frag (Varyings input) : SV_Target
            {
                // Output fully transparent color
                return half4(0, 0, 0, 0);
            }
            ENDHLSL
        }
    }
}