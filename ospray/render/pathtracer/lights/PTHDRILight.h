/********************************************************************* *\
 * INTEL CORPORATION PROPRIETARY INFORMATION                            
 * This software is supplied under the terms of a license agreement or  
 * nondisclosure agreement with Intel Corporation and may not be copied 
 * or disclosed except in accordance with the terms of that agreement.  
 * Copyright (C) 2014 Intel Corporation. All Rights Reserved.           
 ********************************************************************* */

// ======================================================================== //
// Copyright 2009-2013 Intel Corporation                                    //
//                                                                          //
// Licensed under the Apache License, Version 2.0 (the "License");          //
// you may not use this file except in compliance with the License.         //
// You may obtain a copy of the License at                                  //
//                                                                          //
//     http://www.apache.org/licenses/LICENSE-2.0                           //
//                                                                          //
// Unless required by applicable law or agreed to in writing, software      //
// distributed under the License is distributed on an "AS IS" BASIS,        //
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. //
// See the License for the specific language governing permissions and      //
// limitations under the License.                                           //
// ======================================================================== //

#pragma once

#include "api/parms.h"
#include "PTHDRILight_ispc.h"

namespace embree
{
  struct HDRILight
  {
    static void* create(const Parms& parms)
    {
      const AffineSpace3f local2world = parms.getTransform("local2world",one);
      const Color L = parms.getColor("L",one);
      ISPCRef pixels = parms.getImage("image");
      return ispc::HDRILight__new((ispc::vec3f&)local2world.l.vx,
                                  (ispc::vec3f&)local2world.l.vy,
                                  (ispc::vec3f&)local2world.l.vz,
                                  (ispc::vec3f&)local2world.p,
                                  (ispc::vec3f&)L,
                                  pixels.ptr);
    }
  };
}