# enforce_supported_platform cookbook

This cookbook provides a library with `Chef::Recipe` helper methods
for enforcing specific platforms in cookbook metadata.

# Usage

Include this cookbook as a dependency in the cookbooks where you wish
to use it.

    depends "enforce_supported_platform"

Then at the top of your recipes you wish to enforce supported
platforms:

    return if skip_unsupported_platform

This prints informational messages to the Chef logger (`Chef::Log`),
and returns from the recipe, meaning no further code in it will be
evaluated.

# License and Author

- Author: Joshua Timberman <opensource@housepub.org>
- Copyright (c) 2012, Joshua Timberman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
