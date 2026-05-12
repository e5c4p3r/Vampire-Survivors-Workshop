# Vampire Survivors Workshop (GameMaker)
 
<img width="1590" height="892" alt="Animation" src="https://github.com/user-attachments/assets/36f52e56-0664-4353-9fec-89209fbb890c" />

## 事前準備
 
請先到 GameMaker 官網或 Steam 下載 GameMaker。
接著，請下載此專案，並使用 GameMaker 打開。Example 資料夾包含已完成的遊戲成品範例，Sprites 資料夾包含需要用到的美術素材。

## Vampire Survivors 簡介

遊玩片段：[https://www.youtube.com/watch?v=bzYEU3rBD-Y](https://www.youtube.com/watch?v=bzYEU3rBD-Y)

Vampire Survivors 是一款簡單但令人上癮的遊戲。武器採取自動攻擊，玩家僅需操作位移，擊敗敵人獲取經驗值升級，並在升級時強化數值，目標是在大量怪物中生存 30 分鐘。

## GameMaker 簡介

GameMaker 是一款專注於 2D 遊戲開發的整合引擎，採用專有的 GML (GameMaker Language) 作為主要開發語言，其語法接近 JavaScript，能兼顧開發速度與邏輯彈性。使用 GameMaker 開發的知名代表作品包含《Undertale》、《Hotline Miami》以及《Hyper Light Drifter》等。

GameMaker 官網也有提供許多高品質的教學，歡迎大家參閱：[https://gamemaker.io/en/tutorials](https://gamemaker.io/en/tutorials)。

## 隨機地圖生成
 
#### 創建 Room

1. 在右側的 **Assets** 面板中點擊右鍵，選擇 **Create** -> **Room**，命名為 **Room1** 並打開。

#### 設置 TileSet

1. 在 **Assets** 面板選擇 **Create** -> **Tile Set**。打開它，將 Sprites 資料夾中的 TX_Tileset_Grass 拉入 **Sprite** 欄位中。
2. 在左側的 Inspector 面板中，點擊右鍵選擇 **Create New Tile Layer**，並將剛才建立的 TileSet 拉入欄位中。

#### 設定攝影機

1. 在左下角的 **Room Settings** 中，為了讓玩家有足夠的移動空間，將 Width (寬度) 跟 Height (高度) 都改成 **3200**。
2. 在左下角找到 **Viewports and Cameras** 並展開。
3. 展開 **Viewport 0**。
4. 將 **Camera Properties** 裡面的寬高設定為 **400 x 225**。
5. 將 **Viewport Properties** 裡面的寬高設定為 **1600 x 900**（這代表把 400x225 的畫面放大到 1600x900 的視窗中顯示）。
6. 確保勾選最上方的 **Enable Viewports**，以及 Viewport 0 的 **Visible**。

#### 撰寫地圖生成程式

1. 在 Assets 面板右鍵選擇 **Create** -> **Folder**，命名為 Objects。
2. 在 Objects 資料夾中點擊右鍵選擇 **Create** -> **Object**，命名為 `obj_Game_Controller`。
3. 打開這個物件，點擊 **Add Event** -> **Other** -> **Room Start**。
4. 彈出語言選擇時請選擇 **GML Code**，並輸入以下程式碼：

```js
randomise(); // 確保每次開啟遊戲時，隨機生成的結果都不一樣

// 計算總共需要幾個 Tile
var roomWidth = round(room_width/16);
var roomHeight = round(room_height/16);

var lay_id = layer_get_id("Tiles_1"); // 抓取剛才在房間建立的圖層 ID
var map_id = layer_tilemap_get_id(lay_id);

for (var i = 0; i < roomWidth; i++){
	for (var j = 0; j < roomHeight; j++){
		var type = irandom_range(1, 127); // 隨機挑選圖案
		
		tilemap_set(map_id, type, i, j);
	}
}
```

5. 最後，回到 Room1，在左側選擇 **Instances** 圖層，將剛才寫好的 `obj_Game_Controller` 拉入畫面中。



## 玩家操控

#### 建立玩家物件

1. 建立一個名為 `obj_Player` 的物件，並把 Knight 的 Sprite 指定給它。
2. 回到 Room1，在 Inspector 中將 **Instances** 圖層往上拖曳，放到 **Tiles_1** 的上方，這樣玩家才會顯示在地圖上面。
3. 將 `obj_Player` 拖拉進房間的 Instances 圖層中。

#### 撰寫移動程式碼

打開 `obj_Player`：

1. 點擊 **Add Event** -> **Create** (此事件會在遊戲剛開始時執行一次，用來設定初始變數)：

```js
walkspeed = 2; // 設定玩家的移動速度
```

2. 點擊 **Add Event** -> **Step** (此事件每秒會執行 60 次，用來持續偵測按鍵與移動)：

```js
// 偵測 WASD 按鍵是否有被按下
var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));
var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));

// 計算出水平與垂直的移動方向 (結果會是 1, 0, 或 -1)
var horizontal = right-left;
var vertical = down-up;

// 根據方向與速度更新玩家座標
x += horizontal * walkspeed;
y += vertical * walkspeed;

// 控制角色面向左邊或右邊
if (horizontal > 0) image_xscale = 1;
if (horizontal < 0) image_xscale = -1;
```

#### 設定攝影機跟隨

1. 在 Room1 左下角的 **Viewports and Cameras** -> **Viewport 0** 中，找到 **Object Following** 並選擇 `obj_Player`。
2. 將下方的 Horizontal Border 與 Vertical Border 都設定成 **100**。



## 敵人系統

#### 建立敵人

1. 建立一個物件命名為 `obj_Enemy_1`，並指定 Slime 的 Sprite。可以先在房間的 Instances 圖層放幾隻作為測試。
2. 建立一個物件命名為 `obj_Enemy_Parent`。
3. 打開 `obj_Enemy_Parent`，打開 **Parent** 面板，並在 **Children** 的地方點擊 + 號，把 `obj_Enemy_1` 新增進去。

#### 設定敵人速度

1. 在 `obj_Enemy_Parent` 中，**Add Event** -> **Create**：

```js
walkspeed = 0;
```

2. 在 `obj_Enemy_1` 中，對 **Create** 事件點擊右鍵，選擇 **Inherit Event** (繼承事件)，並修改內容如下：

```js
event_inherited(); // Inherit the parent event (執行父物件的內容)

walkspeed = 0.3; // 覆寫這隻怪物的移動速度
```

3. 可以複製 `obj_Enemy_1` 來製作第二種怪物，只要更改 Sprite 與 walkspeed 即可。

#### 生成敵人與追蹤邏輯

打開 `obj_Game_Controller`：

1. **Add Event** -> **Create**：

```js
// 設定敵人移動計時器
alarmTime[0] = 10;
alarm[0] = alarmTime[0];

// 設定敵人生成計時器
alarmTime[1] = 10;
alarm[1] = alarmTime[1];

// 設定敵人生成的半徑距離
spawn_radius = 300;
```

2. **Add Event** -> **Alarm** -> **Alarm 0** (處理所有敵人的追蹤與深度排序，我們把它寫在計時器裡可以節省效能)：

```js
with(obj_Enemy_Parent){
    // 面向玩家並設定速度
	direction = point_direction(x, y, obj_Player.x, obj_Player.y);
	speed = walkspeed;

    // 翻轉圖片面向
	if (x > obj_Player.x) image_xscale = 1;
	else image_xscale = -1;
	
    // 讓位於畫面上方的物件被下方的物件遮擋 (深度排序)
	depth = -y;
}

// 玩家也需要進行深度排序
obj_Player.depth = -obj_Player.y;

// 重置計時器
alarm[0] = alarmTime[0];
```

3. **Add Event** -> **Alarm** -> **Alarm 1** (在玩家周圍隨機生成敵人)：

```js
// 取得 0 到 360 度的隨機角度
var dir = random(360);

// 計算出距離玩家半徑之外的座標
var xx = obj_Player.x + lengthdir_x(spawn_radius, dir);
var yy = obj_Player.y + lengthdir_y(spawn_radius, dir);

// 隨機生成一種敵人
if (irandom_range(1, 2) == 1) instance_create_layer(xx, yy, "Instances", obj_Enemy_1);
else instance_create_layer(xx, yy, "Instances", obj_Enemy_2);

// 重置計時器
alarm[1] = alarmTime[1];
```



## 傷害與血量 UI

#### 設定血量與傷害值

1. 打開 `obj_Player`，在 **Create** 事件最下方新增：

```js
max_hp = 100;
hp = max_hp;
```

2. 打開 `obj_Enemy_Parent`，在 **Create** 事件最下方新增：

```js
dps = 0; // 每秒傷害值
```

3. 回到 `obj_Enemy_1` 與 `obj_Enemy_2` 的 Create 事件中設定它們各自的 dps 數值。

#### 撰寫扣血邏輯

打開 `obj_Game_Controller` 的 **Alarm 0** 事件，在 `with(obj_Enemy_Parent){}` 的大括號中的最下方加入：

```js
// 如果這個敵人碰到玩家
if (place_meeting(x, y, obj_Player)){
    // 計算應該扣除的血量
    obj_Player.hp -= dps / (60 / other.alarmTime[0]);
    show_debug_message(dps / (60 / other.alarmTime[0]));
    
    // 如果玩家血量歸零，重新開始遊戲
    if (obj_Player.hp <= 0){
        game_restart();
    }
}
```

#### 顯示血量條

打開 `obj_Player`，**Add Event** -> **Draw** -> **Draw GUI**：

```js
// 在畫面的左上角畫出血量條，會根據數值自動變色
draw_healthbar(20, 40, 220, 60, (hp / max_hp) * 100, c_black, c_red, c_lime, 0, true, true);
```



## 武器系統與傷害判定

我們將設計兩種武器：近戰揮砍 (Slash) 與 投擲斧頭 (Axe)。
#### 建立武器物件

1. 建立三個物件：`obj_Weapon_Parent`、`obj_Weapon_Slash`、`obj_Weapon_Axe`。
2. 將 Slash 與 Axe 拉入 `obj_Weapon_Parent` 的 **Children** 中。
3. 在 `obj_Weapon_Parent` 的 **Create** 事件中設定變數：

```js
dmg = 0;
hit_list = []; // 用來紀錄已經打中過的敵人，避免重複扣血
```

4. 回到 Slash 與 Axe 物件裡面使用 Inherit Event，並設定它們各自的 dmg 數值。

#### 設定武器施放

打開 `obj_Player`：

1. 在 **Create** 事件中新增武器的冷卻計時器：

```js
alarmtime[0] = 60; // 揮砍冷卻
alarmtime[1] = 90; // 斧頭冷卻

alarm[0] = alarmtime[0];
alarm[1] = alarmtime[1];
```

2. **Add Event** -> **Other** -> **User Events** -> **User Event 0** (處理揮砍的生成)：

```js
var slash = instance_create_layer(x, y, "Instances", obj_Weapon_Slash);

slash.image_xscale = image_xscale;
slash.xoffset = 15 * image_xscale;
```

3. **Add Event** -> **Other** -> **User Events** -> **User Event 1** (處理斧頭的生成)：

```js
var axe = instance_create_layer(x, y, "Instances", obj_Weapon_Axe);

axe.direction = random_range(45, 135);
axe.speed = 4;
axe.gravity = 0.1;
axe.friction = 0.01;
```

4. **Add Event** -> **Alarm** -> **Alarm 0**：

```js
event_user(0);
alarm[0] = alarmtime[0];
```

5. **Add Event** -> **Alarm** -> **Alarm 1**：

```js
event_user(1);
alarm[1] = alarmtime[1];
```

#### 武器的個別行為

打開 `obj_Weapon_Slash`：

1. **Create** 事件中新增：

```js
xoffset = 0;
```

2. **Step** 事件中新增：

```js
// 讓揮砍特效跟著玩家移動
x = obj_Player.x + xoffset;
y = obj_Player.y;
```

3. **Add Event** -> **Other** -> **Animation End** 中新增：

```js
// 動畫播完就銷毀物件
instance_destroy();
```

打開 `obj_Weapon_Axe`：

1. **Step** 事件中新增：

```js
// 讓斧頭在空中旋轉
image_angle += 10;
```

2. **Add Event** -> **Other** -> **Views** -> **Outside View 0** 中新增：

```js
// 飛出畫面外就銷毀物件
instance_destroy();
```

#### 武器傷害判定

1. 打開 `obj_Enemy_Parent`，**Add Event** -> **Create**：

```js
hp = 0;
```

2. 分別設定敵人各自的血量。

3. 打開 `obj_Weapon_Parent`，**Add Event** -> **Step**：

(請參考：[https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Movement_And_Collisions/Collisions/collision_rectangle_list.htm](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Movement_And_Collisions/Collisions/collision_rectangle_list.htm))

```js
// 建立一個清單來儲存矩形範圍內的所有敵人
var _list = ds_list_create();
var _num = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_Enemy_Parent, false, true, _list, false);

if _num > 0
{
    for (var i = 0; i < _num; ++i;)
    {
		var _target = _list[| i];
        
        // 檢查這個敵人是不是還沒被這把武器打過
		if (!array_contains(hit_list, _target)) {
			array_push(hit_list, _target);
			
            // 扣除敵人血量
		    _target.hp -= dmg;
		    
            // 如果敵人血量歸零則銷毀敵人
			if (_target.hp <= 0) instance_destroy(_target);
		}
    }
}
// 清除清單釋放記憶體
ds_list_destroy(_list);
```



## 受傷閃爍與擊退效果

#### 設定敵人受傷參數

打開 `obj_Enemy_Parent` 的 **Create** 事件，在最下方新增：

```js
flash_timer = 0;
kb_speed = 0;
kb_dir = 0;
```

#### 觸發受傷效果

 打開 `obj_Weapon_Parent`，在 **Step** 事件的傷害判定邏輯（`_target.hp -= dmg;` 前面）新增：

```js
// 設定敵人的閃爍時間為 5 幀
_target.flash_timer = 5;

// 計算擊退方向：遠離玩家
_target.kb_dir = point_direction(obj_Player.x, obj_Player.y, _target.x, _target.y);

// 設定擊退的初始速度
_target.kb_speed = 1;
```

#### 受傷閃爍效果

打開 `obj_Enemy_Parent`，**Add Event** -> **Draw** -> **Draw**：

```js
if (flash_timer > 0){
    flash_timer--;
    
    // 開啟 GPU 霧氣效果把圖片塗白
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
}
else{
    draw_self();
}
```

#### 實作擊退位移

打開 `obj_Game_Controller`，進入 **Alarm 0** 事件，找到寫在 `with(obj_Enemy_Parent){}` 裡面的移動邏輯，將原本控制方向與速度的程式碼改為以下判斷式：

```js
if (kb_speed > 0){
    direction = kb_dir;
    speed = kb_speed;
    
    // 逐漸降低擊退速度
    kb_speed -= 0.3;
}
else{
    // 正常追蹤玩家
    direction = point_direction(x, y, obj_Player.x, obj_Player.y);
    speed = walkspeed;
}
```



## 經驗球與升級系統

#### 製作經驗球

1. 建立 `obj_XP` 物件並指定經驗球的 Sprite。
2. 在 **Create** 事件中新增：

```js
active = false; // 是否啟動飛向玩家
```

3. **Step** 事件中新增：

```js
// 如果還沒被啟動，檢查與玩家的距離
if (!active){
    if (point_distance(x, y, obj_Player.x, obj_Player.y) < 100){
        active = true;
    }
}
else{
    // 啟動後自動飛向玩家
    move_towards_point(obj_Player.x, obj_Player.y, 2);
}
```

#### 怪物掉落經驗

打開 `obj_Enemy_Parent`，**Add Event** -> **Destroy**：

```js
instance_create_layer(x, y, "Instances", obj_XP);
```

#### 玩家吸收經驗與升級

打開 `obj_Player`：

1. **Create** 事件中新增數值：

```js
xp = 0;
next_xp = 10;
level = 0;
```

2. **Add Event** -> **Collision** -> **Objects** -> **obj_XP** (碰到經驗球時觸發)：

```js
xp += 1;

if (xp >= next_xp){
	xp = 0;
	level += 1;
    // 下一級需要更多經驗
	next_xp += 1 + level; 
	
    // 升級獎勵：補滿血與減少武器冷卻時間
	hp = max_hp;
	alarmtime[0] *= 0.9;
	alarmtime[1] *= 0.9;
}

// 吃掉經驗球後將其銷毀
instance_destroy(other.id);
```

#### 繪製經驗條 UI

打開 `obj_Player` 的 **Draw GUI** 事件，在原本的血條下方加入：

```js
// 經驗條
draw_healthbar(0, 0, display_get_gui_width(), 20, (xp / next_xp) * 100, c_black, c_aqua, c_aqua, 0, true, true);

// 等級文字
draw_set_halign(fa_center);
draw_text_transformed(display_get_gui_width()/2, 20, $"Level: {level}", 2, 2, 0);
```

## 到這裡就結束啦！

恭喜你完成了一個基礎的 Vampire Survivors 遊戲原型！接下來可以試著新增更多種不同的敵人、武器，或是增加隨機選取升級數值、寶箱等要素。除此之外，遊戲優化也是這類遊戲非常重要的一環，可以試著研究如何讓遊戲在上千個敵人的情況下仍能流暢運行。希望這個教學讓你有所收穫～
