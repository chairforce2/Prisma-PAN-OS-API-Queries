
read -p "Enter API key: " key
# user="USER INPUT"

echo "Do you know the Prisma Access API well enough to specify serviceType, addrType, location, etc?"
read -p "[y/n]" answer

echo "Are you querying a lab tenant?"
read -p "[y/n]" IsLab

if [[ $IsLab = y ]] ; then
ApiUrl="https://api.lab.gpcloudservice.com/getPrismaAccessIP/v2"
else
ApiUrl="https://api.gpcloudservice.com/getPrismaAccessIP/v2"
fi

if [[ $answer = y ]] ; then
read -p "Enter desired IPs (gp_gateway / gp_portal / all): " NodeType
read -p "addrType (all / active / reserved): " addressType
read -p "location (all / deployed): " loc 

else

echo "what is your Use case?"
echo "(1) Get current active IPs to whitelist for Prisma Access users to internet apps"
echo "(2) Get current active, passive, and reserved IPs to whitelist for Primsa Access users to internet apps"
echo "(3) Get every possible Primsa Access egress IP. Check the API docs here to figure it out: https://docs.paloaltonetworks.com/prisma/prisma-access/prisma-access-panorama-admin/prisma-access-overview/retrieve-ip-addresses-for-prisma-access "

read -p "Enter the number of your use case: " UseCaseNumber

case $UseCaseNumber in 
    1)
        NodeType=gp_gateway
        addressType=active
        loc=deployed
        ;;
    2)
        NodeType=gp_gateway
        addressType=all
        loc=deployed
        ;;
    3)
        NodeType=all
        addressType=all
        loc=all
        ;;

    *)
        echo "invalid entry"
        exit
        ;;
esac


fi
touch ./option.txt
echo { '"serviceType"': '"'$NodeType'"', '"addrType"': '"'$addressType'"', '"location"': '"'$loc'"' } > option.txt
curl -X POST -d @option.txt -k -H "header-api-key:$key" "$ApiUrl" > ./Prisma-IPs.txt
echo "   "
echo "    "
echo "Below is a list of zones and addresses based on your use case. If you have multiple zones, then the zones and addresses should be in the same order."
echo "   "
echo "The first 'addresses' line will correspond to the first zone, the second 'addresses' line to the second zone listed, etc"
echo "   "
grep -o -E "\"zone\": \"(.*?)\"" ./prisma-IPs.txt
grep -o -E "\"addresses\": \[(.*?)\]" ./prisma-IPs.txt
