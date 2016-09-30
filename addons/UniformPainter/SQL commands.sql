ALTER TABLE `a3wasteland`.`playersave` 
ADD COLUMN `UniformTexture` VARCHAR(4096) NOT NULL DEFAULT '""' COMMENT '' AFTER `WastelandItems`,
ADD COLUMN `BackpackTexture` VARCHAR(4096) NOT NULL DEFAULT '""' COMMENT '' AFTER `UniformTexture`;
