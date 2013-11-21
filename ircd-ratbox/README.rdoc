= DESCRIPTION:
This is a preliminary version of the recipe to install and configure the ratbox
IRC server version 2.x. It pretty much resembles the sample config provided by
the source package. You can either configure it directly on the node or
preferably add the required attributes to the server role.

= REQUIREMENTS:

= USAGE:
Please note that if you ovverride the [:ircd][:auth] namespace all attributes
that are defined by the default config have to be defined, as no checking for
their existence is done yet.

= LICENSE and AUTHOR:

Author:: Łukasz Jernaś (<deejay1@srem.org>)

Copyright:: 2011, Łukasz Jernaś

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
