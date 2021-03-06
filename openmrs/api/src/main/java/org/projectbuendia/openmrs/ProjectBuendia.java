// Copyright 2015 The Project Buendia Authors
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not
// use this file except in compliance with the License.  You may obtain a copy
// of the License at: http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distrib-
// uted under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
// OR CONDITIONS OF ANY KIND, either express or implied.  See the License for
// specific language governing permissions and limitations under the License.

package org.projectbuendia.openmrs;

import org.openmrs.BaseOpenmrsObject;

import java.io.Serializable;

/**
 * Model class, which is currently unused. This only exists to give us a
 * sample to extend if/when we need to store our own model classes in OpenMRS.
 */
public class ProjectBuendia extends BaseOpenmrsObject implements Serializable {
    private static final long serialVersionUID = 1L;
    private Integer id;

    @Override public Integer getId() {
        return id;
    }

    @Override public void setId(Integer id) {
        this.id = id;
    }
}