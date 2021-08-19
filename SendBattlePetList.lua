

--Triggered by recieving !shareownedpets as a whisper

function CBPO_GetOwnedPetsString() --get a a string with the number of each pet owned as shared by the huge array CBPO_IDsList
    local OwnedPets = "";
	for _,id in ipairs(CBPO_IDsList) do 
		if C_PetJournal.GetOwnedBattlePetString(id) ~= nil and CBPO_BinaryisTradable(id) then --only add if it's tradable
			OwnedPetsString = OwnedPetsString .. string.sub(C_PetJournal.GetOwnedBattlePetString(id),22,-4) 
		else 
			OwnedPetsString = OwnedPetsString .. 0 
		end
	end 
	return a;
 end
 
 
function CBPO_ShareBattlePetsBattlePets() --Sent a starter message, then split OwnedPetsString into bitesized pieces to be sent one by one
    local OwnedPetsString = CBPO_GetOwnedPetsString(); 
	local SecondMessage = ""; 
	local NumberOfMessages = floor(strlen(OwnedPetsString)/244)+1; 
	local MessageKey = math.random(1000, 9999);
	local FirstMessage = "The following (" .. NumberOfMessages .. ") messages are CheckBattlePets' version 1 sharing the battle pets owned by [" .. GetUnitName("player", false) .. "] with key " .. MessageKey;
    C_ChatInfo.SendAddonMessage("CBPO", FirstMessage, CBPO_ChatType(true))
    for i=1,NumberOfMessages,1 do
		SecondMessage = string.sub(OwnedPetsString,0,244);
		SecondMessage = MessageKey .. SecondMessage;
		OwnedPetsString =  string.sub(OwnedPetsString,245,-1);
		C_ChatInfo.SendAddonMessage("CBPO", SecondMessage, CBPO_ChatType(false));
	end
end


function CBPO_BinaryisTradable(petID)--Returns if the pet is tradable. Takes array position not pet ID
    local iT = select(9,C_PetJournal.GetPetInfoBySpeciesID(petID))
    return iT
end

function CBPO_ChatType(a) --Returns if user is in a raid or party, or guild if neither
    if GetNumGroupMembers()>5 then return "RAID" end
    if GetNumGroupMembers()>0 then return "PARTY" end
	if a then print("Not in a party or raid. Defaulting to share in guild."); end
	return "GUILD"
    end
	
CBPO_ShareBattlePetsBattlePets()
