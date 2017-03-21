%module mkldnn

%{
    #define SWIG_FILE_WITH_INIT
    #include "common.h"
    #include "layer_factory.h"
    #include "layer.h"
    #include "pooling.h"
    #include "max_pooling.h"
    #include "avg_pooling.h"
    #include "mkldnn_conv.h"
    #include "relu.h"
    #include "mkldnn_softmax.h"
    #include "local_response_normalization.h"
%}

%include "numpy.i"

%init %{
    import_array();
    global_init();
%}

%apply ( float* IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4 )
    {( float* x, int x_d1, int x_d2, int x_d3, int x_d4 )}
%apply ( float* INPLACE_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4 )
    {( float* gx, int gx_d1, int gx_d2, int gx_d3, int gx_d4 )}
%apply ( float* IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4 )
    {( float* W, int W_d1, int W_d2, int W_d3, int W_d4 )}
%apply ( float* INPLACE_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4 )
    {( float* gW, int gW_d1, int gW_d2, int gW_d3, int gW_d4 )}
%apply ( float* IN_ARRAY1, int DIM1 )
    {( float* b, int b_d1 ),
     /* Softmax_2D/4D, Ravel 2D or 4D nparray to 1D to unify interface */
     ( float* x, int dummy_x )}
%apply ( float* INPLACE_ARRAY1, int DIM1 )
    {( float* gb, int gb_d1 ),
     ( float* y, int dummy_y )}
%apply ( int* IN_ARRAY1, int DIM1 )
    {( int* dims, int ndim )}
%apply ( float* INPLACE_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4 )
    {( float* y, int y_d1, int y_d2, int y_d3, int y_d4 )}
%apply ( float* IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4 )
    {( float* gy, int gy_d1, int gy_d2, int gy_d3, int gy_d4 )}
%apply ( float* IN_ARRAY1, int DIM1)
    {( float* x, int x_size)}
%apply ( float* INPLACE_ARRAY1, int DIM1)
    {( float* y, int y_size)}
%apply ( float* IN_ARRAY1, int DIM1)
    {( float* gy, int gy_size)}
%apply ( float* INPLACE_ARRAY1, int DIM1)
    {( float* gx, int gx_size)}

%include "common.h"
%include "layer_factory.h"
%include "layer.h"
%include "pooling.h"
%include "max_pooling.h"
%include "avg_pooling.h"
%include "mkldnn_conv.h"
%include "relu.h"
%include "mkldnn_softmax.h"
%include "local_response_normalization.h"

%template(Layer_F32) Layer<float>;
%template(Convolution2D_F32) Convolution2D<float>;
%template(Pooling_F32) Pooling<float>;
%template(MaxPooling_F32) MaxPooling<float>;
%template(Layer_F32) Layer<float>;
%template(Relu_F32) Relu<float>;
%template(AvgPooling_F32) AvgPooling<float>;
%template(Softmax_F32) Softmax<float>;
%template(LocalResponseNormalization_F32) LocalResponseNormalization<float>;
