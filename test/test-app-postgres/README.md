test-app-postgres
=================

A sample jaxrs,cdi,jpa application to be deployed on openshift environments using WildFly Galleon S2I image.

The file provisioning.xml is used by Galleon to provision the WildFly server. 
The server is pre-configured with postgresql driver and datasource.

The file local-galleon-feature-packs.txt contains the postgresql feature-pack download URL 
and its installation path into the local maven repository.
