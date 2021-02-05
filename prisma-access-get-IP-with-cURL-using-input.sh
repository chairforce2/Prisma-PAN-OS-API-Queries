
read -p "Enter API key: " key
# user="USER INPUT"

echo "Do you know the Prisma Access API well enough to specify serviceType, addrType, location, etc?"
read -p "[y/n]" answer
if [[ $answer = y ]] ; then
read -p "Enter desired IPs (gp_gateway / gp_portal / all): " NodeType
read -p "addrType (all / active / reserved): " addressType
read -p "location (all / deployed): " loc 

touch ./option.txt
echo { '"serviceType"': '"'$NodeType'"', '"addrType"': '"'$addressType'"', '"location"': '"'$loc'"' } > option.txt


else

echo "Do you just want to know the IPs you need to whitelist right now for your Prisma Access users to access internet apps?"
read -p "[y/n]" answer

if [[ $answer = y ]] ; then
NodeType=gp_gateway
addressType=active
loc=deployed
touch ./option.txt
echo { '"serviceType"': '"'$NodeType'"', '"addrType"': '"'$addressType'"', '"location"': '"'$loc'"' } > option.txt


else

echo "Do you just want to know every IPs you may ever need to whitelist if you expand you Prisma Access user deployment globally?"
read -p "[y/n]" answer
if [[ $answer = y ]] ; then
NodeType=gp_gateway
addressType=all
loc=all
touch ./option.txt
echo { '"serviceType"': '"'$NodeType'"', '"addrType"': '"'$addressType'"', '"location"': '"'$loc'"' } > option.txt


else
echo "ok, well i'm just going to give you every possible egress IP since you aren't sure what you want.... check the API docs here to figure it out: https://docs.paloaltonetworks.com/prisma/prisma-access/prisma-access-panorama-admin/prisma-access-overview/retrieve-ip-addresses-for-prisma-access"

fi
fi
fi

curl -X POST -d @option.txt -k -H "header-api-key:$key" "https://api.lab.gpcloudservice.com/getPrismaAccessIP/v2"

