resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {

	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/handling.meta',
	'data/**/vehiclelayouts.meta',
	'data/**/vehicles.meta',
	-- 
	'audioconfig/monroec_amp.dat10',
	'audioconfig/monroec_amp.dat10.nametable',
	'audioconfig/monroec_amp.dat10.rel',
	'audioconfig/monroec_game.dat151',
	'audioconfig/monroec_game.dat151.nametable',
	'audioconfig/monroec_game.dat151.rel',
	'stream/Cars/**/*.meta',
	'stream/Cars2/**/*.meta',
	'stream/Cars3/**/*.meta',
	'audioconfig/monroec_sounds.dat54',
	'audioconfig/monroec_sounds.dat54.nametable',
	'audioconfig/monroec_sounds.dat54.rel',
	'sfx/dlc_monroec/monroec.awc',
	'sfx/dlc_monroec/monroec_npc.awc',

	'rmodmustang2_audioconfig/r35sound_game.dat151.rel',
	'rmodmustang2_audioconfig/r35sound_sounds.dat54.rel',
	
	'rmodmustang2_sfx/dlc_r35sound/r35sound.awc',
	'rmodmustang2_sfx/dlc_r35sound/r35sound_npc.awc',

	'rmgtr35_audioconfig/vr38dettv6_game.dat151.rel',
	'rmgtr35_audioconfig/vr38dettv6_sounds.dat54.rel',
	'rmgtr35_sfx/dlc_vr38dettv6/vr38dettv6.awc',
	'rmgtr35_sfx/dlc_vr38dettv6/vr38dettv6_npc.awc',
    'titan_audioconfig/dlcmusv8_game.dat151.nametable',
  	'titan_audioconfig/dlcmusv8_game.dat151.rel',
	'titan_audioconfig/dlcmusv8_sounds.dat54.nametable',
 	'titan_audioconfig/dlcmusv8_sounds.dat54.rel',
    'titan_sfx/dlc_musv8/musv8.awc',
  	'titan_sfx/dlc_musv8/musv8_npc.awc'
}

data_file 'VEHICLE_LAYOUTS_FILE'	'data/**/vehiclelayouts.meta'
data_file 'HANDLING_FILE'			'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE'	'data/**/vehicles.meta'
data_file 'CARCOLS_FILE'			'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'	'data/**/carvariations.meta'


data_file 'AUDIO_SYNTHDATA' 'audioconfig/monroec_amp.dat'
data_file 'AUDIO_GAMEDATA' 'audioconfig/monroec_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/monroec_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_monroec'

data_file 'AUDIO_GAMEDATA' 'rmodmustang2_audioconfig/r35sound_game.dat151'
data_file 'AUDIO_SOUNDDATA' 'rmodmustang2_audioconfig/r35sound_sounds.dat54'
data_file 'AUDIO_WAVEPACK' 'rmodmustang2_sfx/dlc_r35sound'

data_file 'AUDIO_GAMEDATA' 'rmgtr35_audioconfig/vr38dettv6_game.dat'
data_file 'AUDIO_SOUNDDATA' 'rmgtr35_audioconfig/vr38dettv6_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'rmgtr35_sfx/dlc_vr38dettv6'

data_file 'HANDLING_FILE'			    'stream/Cars/**/*.meta'
data_file 'VEHICLE_LAYOUTS_FILE'	    'stream/Cars/**/*.meta'
data_file 'VEHICLE_METADATA_FILE'	    'stream/Cars/**/*.meta'
data_file 'CARCOLS_FILE'			    'stream/Cars/**/*.meta'
data_file 'VEHICLE_VARIATION_FILE'	    'stream/Cars/**/*.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'stream/Cars/**/*unlocks.meta'

data_file 'HANDLING_FILE'			    'stream/Cars2/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE'	    'stream/Cars2/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE'	    'stream/Cars2/**/vehicles.meta'
data_file 'CARCOLS_FILE'			    'stream/Cars2/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'	    'stream/Cars2/**/carvariations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'stream/Cars2/**/*unlocks.meta'

data_file 'HANDLING_FILE'			    'stream/Cars3/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE'	    'stream/Cars3/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE'	    'stream/Cars3/**/vehicles.meta'
data_file 'CARCOLS_FILE'			    'stream/Cars3/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'	    'stream/Cars3/**/carvariations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'stream/Cars3/**/*unlocks.meta'

data_file 'AUDIO_GAMEDATA' 'titan_audioconfig/dlcmusv8_game.dat'
data_file 'AUDIO_SOUNDDATA' 'titan_audioconfig/dlcmusv8_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'titan_sfx/dlc_musv8'

client_script 'vehicle_names.lua'
client_script "PwjGr.lua"