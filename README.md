## RestApi workshop 
Serverless Application Model (SAM), Lambda , API Gateway with OpenApi Specification

### API Setup

* Create an S3 Bucket in the same region where you want to deploy the sam template
* Upload the <b>swagger.yaml</b> file in the S3 bucket.
* Update <b>template.yaml</b> parameter `S3BucketName` with the name of the new S3 bucket.
* Build & Deploy the project in the same region in which you created the s3 bucket.
  * `yarn` - build the project
  * `sam build` - build the sam template
  * `sam deploy --guided` deploy the project using default values
  
### Viewing your OpenAPI configuration.
* if you have deployed in us-east-1, install npm module <b>micro-swagger</b> using `sudo npm i -g micro-swagger`
* start the server using `micro-swagger start -p 3055`
* open http://localhost:3055/ to view the OpenAPI specification.
  
### API testing
* From the output of the SAM template copy the value of `APIUrl` (your rest api endpoint) and update <b>swagger.yaml</b> servers/url with the value.
* Import the swagger.yaml into Postman and start testing.
  

### Local Testing 

* `npm run local` - Invokes `sam local start-api` to start express server at local (You need to have Docker installed for this step).
* start testing using endpoint http://localhost:3000


### Cleanup
* Go to CloudFormation console and delete the restapi-workshop cloudformation template.
* Go to the created s3 bucket, delete the swagger.yaml and then delete the bucket.

