ntp Cookbook
============
[![Build Status](https://travis-ci.org/jhx/cookbook-ntp.png?branch=master)](https://travis-ci.org/jhx/cookbook-ntp)
[![Dependency Status](https://gemnasium.com/jhx/cookbook-ntp.png)](https://gemnasium.com/jhx/cookbook-ntp)

Installs and configures ntp (network time daemon).


Requirements
------------
### Cookbooks
No dependencies.

### Platforms
The following platforms are supported and tested under Test Kitchen:

- CentosOS 5.10, 6.5

Other RHEL family distributions are assumed to work. See [TESTING](TESTING.md) for information about running tests in Opscode's Test Kitchen.


Attributes
----------
Refer to [`attributes/default.rb`](attributes/default.rb) for default values.

- `node['ntp']['server']` - IP address of time server used to sync node


Recipes
-------
This cookbook provides one main recipe for configuring a node.

- `default.rb` - *Use this recipe* to install and configure `ntp`.

### default
This recipe installs and configures `ntp`.


Usage
-----
On client nodes, use the default recipe:

````javascript
{ "run_list": ["recipe[ntp]"] }
````

The following are the key items achieved by this cookbook:

- installs package `ntp`
- stops, disables service `ntp`
- creates configuration file `/etc/cron.hourly/ntpdate`


License & Authors
-----------------
- Author:: Doc Walker (<doc.walker@jameshardie.com>)

````text
Copyright 2013-2014, James Hardie Building Products, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
````
