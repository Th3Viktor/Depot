--This is where errors are handled and displayed
function errorHandler(err)
    os.execute("cls")
    print("Something went wrong...")
    print("Error: " .. err)
    os.execute("timeout 3")
    main()
end

--This is where account processing is done (Authentication, Creation & Checking)
function accAuth()
    print("Please enter your Account Name: ")
    accName = io.read()
    print("Please enter your Account Password: ")
    accPass = io.read()
    status = xpcall(accCheck, errorHandler)
    checkUserPass = file:read()
    if(checkUserPass == accPass)
        then
            print("Password verified, loading account information...")
            item1 = file:read()
            item2 = file:read()
            item3 = file:read()
            accInfo()
        else
            print("Account/Password is invalid, Please try again.")
            os.execute("timeout 3")
            main()
        end
end

function accCreate()
    print("Create your account name: ")
    MakeAccName = io.read()
    print("Create your account password: ")
    MakeAccPass = io.read()
    file = io.open("accounts/" .. MakeAccName, "w") -- Fixed it
    file:write(MakeAccPass, "\n") --<<< This is the line that caused the error
    file:write(0, "\n")
    file:write(0, "\n")
    file:write(0, "\n")
    file:close()
    os.execute("timeout 2")
    main()
end

function accCheck()
    file = assert(io.open("accounts/" .. accName, "r+"), "User not found")
end

--Transaction Query & "GUI"
function accInfo()
    os.execute("cls")
    print("Account Succesfully Found!")
    print("Initializing...")
    print("Steel: " .. item1 .. " (Units)")
    print("Gold: " .. item2 .. " (Units)")
    print("Diamond: " .. item3 .. " (Units)")
    print("What would you like to do?")
    print("1. Deposit  2. Withdraw 3. Exit")
    userOpt = io.read()
    if(userOpt == "1")
        then
            userAction = "Deposit"
            userQuery()
            deposit()
        elseif(userOpt == "2")
        then
            userAction = "Withdraw"
            userQuery()
            if(userConfirm == "1")
                then
                    withdraw()
                else
                    main()
                end
        elseif(userOpt == "3")
        then
            main()
        else
            accInfo()
    end
end

function userQuery()
    os.execute("cls")
    print("Select Item: ")
    print("1. Steel 2. Gold 3. Diamond")
    itemType = io.read()
    if(itemType == "1")
        then
            itemType = "Steel"
        elseif(itemType == "2")
            then
                itemType = "Gold"
        elseif(itemType == "3")
            then
                itemType = "Diamond"
            else
                os.execute("cls")
                print("Invalid itemType...")
                os.execute("timeout 1")
                userQuery()
            end
    print("Enter an amount: ")
    itemVal = io.read()
    print("Would you like to [" .. userAction .. "] [" .. itemVal .. "] units of [" .. itemType .. "]")
    print("(Enter Numeric Value) 1. Yes         2. No")
    userConfirm = io.read()
    file:close()
    if(userConfirm == "1" and userAction == "Deposit")
        then
            deposit()
        elseif(userConfirm == "1" and userAction == "Withdraw")
        then
            withdraw()
        elseif(userConfirm == "2")
        then
            userQuery()
        else
            os.execute("")
            print("Invalid Option...")
            os.execute("timeout 3")
            userQuery()
    end
            
end
--This is where the transaction processes are located (Deposit & Withdrawl)
function deposit()
    if(itemType == "Steel")
    then
        file = io.open("accounts/" .. accName, "w")
        os.remove("accounts/" .. accName)
        file = io.open("accounts/" .. accName, "w")
        file:write(accPass, "\n")
        file:write(item1 + tonumber(itemVal), "\n")
        file:write(item2, "\n")
        file:write(item3, "\n")
    elseif(itemType == "Gold")
    then
        file = io.open("accounts/" .. accName, "w")
        os.remove("accounts/" .. accName)
        file = io.open("accounts/" .. accName, "w")
        file:write(accPass, "\n")
        file:write(item1, "\n")
        file:write(item2 + itemVal, "\n")
        file:write(item3, "\n")
    elseif(itemType == "Diamond")
    then
        file = io.open("accounts/" .. accName, "w")
        os.remove("accounts/" .. accName)
        file = io.open("accounts/" .. accName, "w")
        file:write(accPass, "\n")
        file:write(item1, "\n")
        file:write(item2, "\n")
        file:write(item3 + itemVal, "\n")
    end
    print(userAction .. " SUCCESSEFUL, returning to Menu...")
    file:close()
    os.execute("timeout 5")
    main()
end

function withdraw()
    if(itemType == "Steel")
    then
        if(tonumber(item1) >= tonumber(itemVal))
        then
            os.remove("accounts/" .. accName)
            file = io.open("accounts/" .. accName, "w")
            file:write(accPass, "\n")
            file:write(item1 - tonumber(itemVal), "\n")
            file:write(item2, "\n")
            file:write(item3, "\n")
        else
            print("Insufficient Material... Returning to Main Menu.")
            os.execute("timeout 3")
            main()
        end
    elseif(itemType == "Gold")
    then
        if(tonumber(item2) >= tonumber(itemVal))
        then
            os.remove("accounts/" .. accName)
            file = io.open("accounts/" .. accName, "w")
            file:write(accPass, "\n")
            file:write(item1, "\n")
            file:write(item2 - tonumber(itemVal), "\n")
            file:write(item3, "\n")
        else
            print("Insufficient Material... Returning to Main Menu.")
            os.execute("timeout 3")
            main()
        end
    elseif(itemType == "Diamond")
    then
        if(tonumber(item3) >= tonumber(itemVal))
        then
            os.remove("accounts/" .. accName)
            file = io.open("accounts/" .. accName, "w")
            file:write(accPass, "\n")
            file:write(item1, "\n")
            file:write(item2, "\n")
            file:write(item3 - tonumber(itemVal), "\n")
        else
            print("Insufficient Material... Returning to Main Menu.")
            os.execute("timeout 3")
            main()
        end
    end
    print(userAction .. " SUCCESSEFUL, returning to Main Menu...")
    file:close()
    os.execute("timeout 5")
    main()
end

-- Main "GUI" interface
function main()
    os.execute("cls")
    print("Depot.lua V1.0")
    print("Powered by: Lua, The Programming Language.")
    print("")
    print("Program By: Vektor")
    print("")
    print("Do you have an account? (Enter Numeric Value)")
    print("1.Yes      2.No      3.Exit      4. Credits")
    userInput = io.read()
    if(userInput == "1")
        then
            accAuth()
        elseif(userInput == "2")
        then
            accCreate()
        elseif(userInput == "3")
        then
            main()
        elseif(userInput == "4")
        then
            os.execute("cls")
            print("Viktor, Author")
            print("Youtube: https://www.youtube.com/channel/UCSuDa3yfU3OgOmtkzBNsDEQ")
            print("Github: https://github.com/Th3Viktor")
            print("")
            print("Thanks for cheking me out :D (Sub to my youtube I think it's still active!)")
            os.execute("pause")
            main()
        else
            main()
    end 
end

--Basic Call to Start
main()