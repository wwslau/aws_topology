
#Dev
thisRegion=$1

ec2-describe-tags --region $thisRegion --filter "resource-type=vpc" > aws.txt
ec2-describe-tags --region $thisRegion --filter "resource-type=subnet" >> aws.txt
ec2-describe-tags --region $thisRegion --filter "resource-type=security-group" >> aws.txt

./r_aws.sh $1
