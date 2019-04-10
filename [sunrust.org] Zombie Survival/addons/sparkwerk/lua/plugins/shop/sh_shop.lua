AddCSLuaFile()

Shop = Shop or {}
Shop.Items = {}

function Shop.AddCosmetic(name, item)
--  item.price = 1
    item.desc = item.desc or ""
    item.update_time = item.update_time or 1
    item.type = "cosmetic"
    item.cosmetic_name = name
    Shop.Items[name] = item
end

function Shop.GetCommission(price)
    return price * 0.10
end

local all_items_earliest_update_time = 1553988443 -- 3/30/2019

function Shop.GetItemUpdateTime(item)
    return math.max(item.update_time or 0, all_items_earliest_update_time)
end

function Shop.GetCosmetic(name)
    return Shop.Items[name] or {
        type = "cosmetic",
        cosmetic_name = name,
        name = name,
        desc = ""
    }
end

function Shop.GetPrettyName(name)
    return Shop.GetCosmetic(name).name
end

Shop.AddCosmetic("tophatmonocle", {name="Top Hat & Monocle",     author = "76561197992080377", price = 145000})
Shop.AddCosmetic("sunglasses",    {name="Sunglasses",            author = "76561197992080377", price =  90000, face_wear = true})
Shop.AddCosmetic("shades",        {name="Shades",                author = "76561197992080377", price =  90000, face_wear = true})
Shop.AddCosmetic("hearteyes",     {name="Heart Eyes",            author = "76561197992080377", price = 115000, face_wear = true})
Shop.AddCosmetic("wizardcap",     {name="Wizard Cap",            author = "76561197992080377", price = 125000})
Shop.AddCosmetic("valveeye",      {name="Valve Eye",             author = "76561197992080377", price =  90000, face_wear = true})
Shop.AddCosmetic("chef",          {name="Chef",                  author = "76561197992080377", price =  75000})
Shop.AddCosmetic("cigar",         {name="Cigar",                 author = "76561197992080377", price = 150000})
Shop.AddCosmetic("civil",         {name="Civil Protection Mask", author = "76561197992080377", price =  90000, face_wear = true})
Shop.AddCosmetic("demon",         {name="Demon Horns",           author = "76561197992080377", price =  90000})
Shop.AddCosmetic("gmanmask",      {name="GMan Balloon Mask",     author = "76561197992080377", price =  75000, face_wear = true})
Shop.AddCosmetic("nvgs",          {name="Night Vision Goggles",  author = "76561197992080377", price = 150000, face_wear = true})
Shop.AddCosmetic("gradcap",       {name="Graduation Cap",        author = "76561197992080377", price =  75000})
Shop.AddCosmetic("spacehelmet",   {name="Space Helmet",          author = "76561197992080377", price = 145000, face_wear = true})
Shop.AddCosmetic("snowmanmask",   {name="Snowman Mask",          author = "76561197992080377", price =  75000, face_wear = true})
Shop.AddCosmetic("turtlecap",     {name="Turtle Cap",            author = "76561197992080377", price =  45000})
Shop.AddCosmetic("headcrab",      {name="Headcrab",              author = "76561197992080377", price = 125000, face_wear = true})
Shop.AddCosmetic("halo",          {name="Angelic Halo",          author = "76561197992080377", price = 145000})
Shop.AddCosmetic("bomb",          {name="Bomb Head",             author = "76561197992080377", price = 125000, face_wear = true})
Shop.AddCosmetic("knighthelmet",  {name="Knight Helmet",         author = "76561197992080377", price = 125000, face_wear = true})
Shop.AddCosmetic("ricehat",       {name="Rice Hat",              author = "76561197992080377", price = 125000})

Shop.AddCosmetic("bigshades",       {name="Big Shades",              author = "76561197989216990", price = 125000, face_wear = true})
Shop.AddCosmetic("skullhelmet",     {name="Skull Helmet",            author = "76561197989216990", price = 165000})
Shop.AddCosmetic("clownnose",       {name="Clown Nose",              author = "76561197989216990", price = 150000, face_wear = true})
Shop.AddCosmetic("catears",         {name="Cat Ears",                author = "76561197989216990", price =  65000})
Shop.AddCosmetic("burgerhat",       {name="Burger Hat",              author = "76561197989216990", price =  65000})
Shop.AddCosmetic("battlehelmet",    {name="Battle Helmet",           author = "76561197989216990", price = 100000})

Shop.AddCosmetic("punishedsnake",  {name="Nuclear Noggin", author = "76561198001581101", price = 125000, face_wear = true})
Shop.AddCosmetic("ssquad",         {name="Soup Squad",     author = "76561198001581101", price =  80000})
Shop.AddCosmetic("standingpillar", {name="Star Duster",    author = "76561198001581101", price = 300000})
Shop.AddCosmetic("turkeytosser",   {name="Turkey Tosser",  author = "76561198001581101", price = 250000})
Shop.AddCosmetic("delticmage",     {name="Deltic Mage",    author = "76561198001581101", price = 200000, face_wear = true})
Shop.AddCosmetic("demonshades",    {name="Demon Shades",   author = "76561198001581101", price = 350000, face_wear = true})
--Shop.AddCosmetic("olimar",        {name="Olimar",         author = "Negi" , price =  80000})

Shop.AddCosmetic("tvhead",               {name="TV Head",          author = "76561197992086646", price = 200000, face_wear = true})
Shop.AddCosmetic("suwako",               {name="Suwako",           author = "76561197992086646", price = 325000})
Shop.AddCosmetic("tenshi",               {name="Tenshi",           author = "76561197992086646", price = 350000})
Shop.AddCosmetic("pumpkin_jackolantern", {name="Jack-o'-lantern",  author = "76561197992086646", price =  75000, face_wear = true})

Shop.AddCosmetic("antlers",              {name="Antlers"        ,  author = "76561197992086646", price =  85000})
Shop.AddCosmetic("tophat_festive",       {name="Festive Top Hat",  author = "76561197992086646", price = 100000})
Shop.AddCosmetic("santa",                {name="Santa Hat"      ,  author = "76561197992086646", price =  85000})

Shop.AddCosmetic("koishihat", {name="Koishi",  author = "76561198028448491", price = 350000})

Shop.AddCosmetic("conehead", {name="Cone Head", author = "76561197968608740", price = 60000})

Shop.AddCosmetic("ember_skull", {
    name = "Ember Skull",
    price = 500000,
    face_wear = true,
    award_lock = "zs_cmp_hlegend",
    award_lock_name = "Human Legend", -- todo: get this from award info
    legendary = true,
    particles = true -- todo: detect this automatically
})

Shop.AuthorInfo =
{
    ["76561197992080377"] = {name = "Epple"},
    ["76561197989216990"] = {name = "Boris"},
    ["76561198001581101"] = {name = "NegativeEight"},
    ["76561197992086646"] = {name = "Gormaoife"},
    ["76561198028448491"] = {name = "Karma"},
    ["76561197968608740"] = {name = "Extreme56"},
}
