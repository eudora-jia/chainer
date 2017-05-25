/*******************************************************************************
* Copyright 2016-2017 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

%module (package="mkldnn.api") inner_product_backward_data
%{
  #define SWIG_FILE_WITH_INIT
  #include <cstddef>
  #include <mkldnn.hpp>
  using mkldnn::handle_traits;

  #include "mdarray.h"
%}

%init %{
  import_array();
%}

%include stl.i
%include exception.i

%feature("flatnested");
%feature("nodefaultctor");

%import support.i
%import memory.i
%import mdarray.i
%import inner_product_forward.i

namespace mkldnn {

%rename (desc) inner_product_backward_data::desc;
%rename (primitive_desc) inner_product_backward_data::primitive_desc;

%exception inner_product_backward_data::desc::desc {
  try {
    $action
  }
  catch (mkldnn::error &e){
    SWIG_exception(SWIG_ValueError, e.message.c_str());
  }
}

struct inner_product_backward_data: public primitive {
    struct desc {
        c_api::mkldnn_inner_product_desc_t data;
        desc(const memory::desc &diff_src_desc,
                const memory::desc &weights_desc,
                const memory::desc &diff_dst_desc);
    };

    struct primitive_desc : public handle<c_api::mkldnn_primitive_desc_t> {
        primitive_desc(const desc &adesc, const engine &aengine,
                const inner_product_forward::primitive_desc
                    &hint_fwd_primitive_desc);

        memory::primitive_desc diff_dst_primitive_desc() const;

        memory::primitive_desc weights_primitive_desc() const;

        memory::primitive_desc diff_src_primitive_desc() const;
    };

    inner_product_backward_data(const primitive_desc &aprimitive_desc,
            const primitive::at &diff_dst, const primitive::at weights,
            const memory &diff_src);
};

}

%template (linear_bd_op) compatible_shape_bd_op<mkldnn::inner_product_backward_data>;
