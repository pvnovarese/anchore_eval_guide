How to import source repos and link scanned images to an application in Anchore Enterprise 

This assumes you already have Anchore Enterprise 4.0.0 or greater deployed and configured and that you have anchorectl confirgured to talk to the Anchore Enterprise API.

More info on anchorectl: https://docs.anchore.com/current/docs/installation/anchorectl/


```
# first, create an application

### pvn@oddish:~ % anchorectl application add jenkins
APPLICATION ID                        NAME      DESCRIPTION
e3f230f9-220f-4660-a127-90cff0dba48c  jenkins



# note here the argument is the Application ID from the application that was added in the previous step
# note this version ID

### pvn@oddish:~ % anchorectl application version list e3f230f9-220f-4660-a127-90cff0dba48c 
VERSION ID                            NAME
800a33f4-8e8f-4fc3-9d11-3a0f7ea1c29d  HEAD

# create SBOM
### pvn@oddish:~ % anchorectl -o json sbom create dir:jenkins > jenkins.sbom.json

# import the SBOM - note the “revision” is the commit hash
# note the ***FIRST*** UUID in the output
### pvn@oddish:~ % anchorectl source import --sbomFile ./jenkins.sbom.json --branch main --repoHost github.com --repoName pvnovarese/jenkins --revision 62fbc3a -o json
{
 "data": {
  "uuid": "80317b93-786a-4ada-83fb-8252bd98316f",
  "account_id": "demo-team",
  "vcs_type": "git",
  "host": "github.com",
  "repository_name": "pvnovarese/jenkins",
  "revision": "62fbc3a",
  "created_at": "2022-05-16T19:31:34Z",
  "last_updated": "2022-05-16T19:31:34Z",
  "analysis_status": "not_analyzed",
  "source_status": "active",
  "metadata_records": [
   {
    "uuid": "ce6d3d37-fced-4f77-bd88-57cddd46f0d8",
    "branch_name": "main"
   }
  ]
 }
}

# make sure it’s imported
### pvn@oddish:~ % anchorectl source list
UUID                                  ACCOUNT ID  HOST                REPOSITORY NAME     REVISION  ANALYSIS STATUS  SOURCE STATUS  CREATED AT            LAST UPDATED
80317b93-786a-4ada-83fb-8252bd98316f  demo-team   github.com          pvnovarese/jenkins  62fbc3a   analyzed         active         2022-05-16T19:31:34Z  2022-05-16T19:31:34Z


# link the imported SBOM to the application:
# note the arguments here are the application ID, the version ID, and the UUID of the source that was just imported.
### pvn@oddish:~ % anchorectl application version artifact add e3f230f9-220f-4660-a127-90cff0dba48c 800a33f4-8e8f-4fc3-9d11-3a0f7ea1c29d source --uuid 80317b93-786a-4ada-83fb-8252bd98316f
ASSOCIATION ID                        SOURCE UUID                           SOURCE STATUS  ANALYSIS STATUS  HOST        REPOSITORY NAME     REVISION
02fe10fc-043d-46c2-ba7e-7d216eaab42f  80317b93-786a-4ada-83fb-8252bd98316f  active         analyzed         github.com  pvnovarese/jenkins  62fbc3a




# optional, add an image to the application
### pvn@oddish:~ % docker pull jenkins/jenkins:latest

# [… output snipped…]

### pvn@oddish:~ % docker tag jenkins/jenkins:latest pvnovarese/jenkins:latest
### pvn@oddish:~ % docker push pvnovarese/jenkins:latest

# [… output snipped…]

# scan image
### pvn@oddish:~ % anchorectl image add pvnovarese/jenkins:latest
IMAGE DIGEST                                                             ANALYSIS STATUS  IMAGE ID                                                          DOCKERFILE MODE  DISTRO  TAG
sha256:a8e8bb34ea99ec2fc9c02141c2611c8734c88dd1fb0f5de12a51bf93cb5a2dd7  not_analyzed     f4079e4b50132c5df88c05b34c7e2e69b3d57b8b2001a9df76273464df328709  <nil>            <nil>   docker.io/pvnovarese/jenkins:latest

# link image to application
### pvn@oddish:~ % anchorectl application version artifact add e3f230f9-220f-4660-a127-90cff0dba48c 800a33f4-8e8f-4fc3-9d11-3a0f7ea1c29d image --image_digest sha256:a8e8bb34ea99ec2fc9c02141c2611c8734c88dd1fb0f5de12a51bf93cb5a2dd7
ASSOCIATION ID                        IMAGE DIGEST                                                             ANALYSIS STATUS  IMAGE STATUS  DISTRO
647292a1-f3de-41c0-ab51-faaec377b09f  sha256:a8e8bb34ea99ec2fc9c02141c2611c8734c88dd1fb0f5de12a51bf93cb5a2dd7  analyzed         active        debian
```
