# ocean_change

An iOS/Android mobile app for Fishermen and other ocean goers to report useful observations to the Oregon Department of Fish and Wildlife (ODFW).

If working in emulatar mode for andriod add the following to a file named network_security_config.xml and DO NOT PUSH TO PROD:

```
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain>10.0.2.2</domain>
    </domain-config>
</network-security-config>
```