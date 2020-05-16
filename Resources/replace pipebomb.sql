TrashJackDaniels
ItemTrashToiletpaper




UPDATE `character_data`
SET `Inventory` = REPLACE(`Inventory`, '"PipeBomb"', '"ItemTrashToiletpaper"')
WHERE `Inventory` LIKE '%"PipeBomb"%' AND `Inventory` NOT LIKE '%"ItemTrashToiletpaper"%';


UPDATE `character_data`
SET `Backpack` = REPLACE(`Backpack`, '"PipeBomb"', '"ItemTrashToiletpaper"')
WHERE `Backpack` LIKE '%"PipeBomb"%' AND `Backpack` NOT LIKE '%"ItemTrashToiletpaper"%';


UPDATE `object_data`
SET `Inventory` = REPLACE(`Inventory`, '"PipeBomb"', '"ItemTrashToiletpaper"')
WHERE `Inventory` LIKE '%"PipeBomb"%' AND `Inventory` NOT LIKE '%"ItemTrashToiletpaper"%';






UPDATE `character_data`
SET `Inventory` = REPLACE(`Inventory`, '"PipeBomb"', '"TrashJackDaniels"')
WHERE `Inventory` LIKE '%"PipeBomb"%' AND `Inventory` NOT LIKE '%"TrashJackDaniels"%';


UPDATE `character_data`
SET `Backpack` = REPLACE(`Backpack`, '"PipeBomb"', '"TrashJackDaniels"')
WHERE `Backpack` LIKE '%"PipeBomb"%' AND `Backpack` NOT LIKE '%"TrashJackDaniels"%';


UPDATE `object_data`
SET `Inventory` = REPLACE(`Inventory`, '"PipeBomb"', '"TrashJackDaniels"')
WHERE `Inventory` LIKE '%"PipeBomb"%' AND `Inventory` NOT LIKE '%"TrashJackDaniels"%';

