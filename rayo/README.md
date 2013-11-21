# DESCRIPTION
[Rayo](http://rayo.org/ "Rayo") is a message-oriented XML protocol for controlling phone calls, audio mixers and a variety of advanced media resources.  This cookbook is to install a [Rayo](http://rayo.org/ "Rayo") Node or Gateway



# REQUIREMENTS

<table>
<colgroup>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
</colgroup>

<thead>
<tr>
  <th style="text-align:left;">Cookbook</th>
  <th style="text-align:left;">Version</th>
</tr>
</thead>

<tbody>
<tr>
  <td style="text-align:left;">Prism</td>
  <td style="text-align:left;">&gt;= 2.0.0</td>
</tr>
<tr>
  <td style="text-align:left;">Cassandra</td>
  <td style="text-align:left;"></td>
</tr>
</tbody>
</table>


# ATTRIBUTES
 Please see attributes file, documentation coming soon ( I promise ), however full documentation can be found on the [Wiki](https://github.com/rayo/rayo-server/wiki "Rayo Wiki"), as well as [source](https://github.com/rayo/rayo-server/ "Rayo Source")

# USAGE

Include the appropriate recipe for your use case, eg a node or a gateway.

# CHANGE LOG

<table>
<colgroup>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
</colgroup>

<thead>
<tr>
  <th style="text-align:left;">Version</th>
  <th style="text-align:left;">Changes</th>
</tr>
</thead>

<tbody>
<tr>
  <td style="text-align:left;">1.0.7</td>
  <td style="text-align:left;">* Inital public release (code cleanup)</td>
</tr>
<tr>
  <td style="text-align:left;"></td>
  <td style="text-align:left;">* Removed artifacts cookbook dependecy</td>
</tr>
<tr>
  <td style="text-align:left;"></td>
  <td style="text-align:left;">* Support chef-solo deployment</td>
</tr>
<tr>
  <td style="text-align:left;">1.0.8</td>
  <td style="text-align:left;">* Fixed undeffined variable</td>
</tr>
<tr>
  <td style="text-align:left;">1.0.9</td>
  <td style="text-align:left;">* Fixed foodcritic errors</td>
</tr>
<tr>
  <td style="text-align:left;"></td>
  <td style="text-align:left;">* Mistakenly used gateway attribute in node remote_file resource, whoops</td>
</tr>
<tr>
  <td style="text-align:left;">1.0.10</td>
  <td style="text-align:left;">* node[&#8220;name&#8221;] is nil, not sure why yet, but node.name works</td>
</tr>
<tr>
  <td style="text-align:left;">1.0.11</td>
  <td style="text-align:left;">* Updated readme for public release</td>
</tr>
<tr>
  <td style="text-align:left;">1.0.12</td>
  <td style="text-align:left;">* Fix readme, markdown tables not supported on community site</td>
</tr>
</tbody>
</table>
