日本の都道府県のデータが半角カンマで区切られた形で記述されたデータファイル(data_utf-8.csv)を読み込み、
探索，修正，整列，データ更新などを行うプログラムです。

各都道府県のデータは、

都道府県名 (英)，都道府県名 (日)，都道府県庁所在地 (英)，
都道府県庁所在地 (日)，人口(× 千人)，面積(×10km2)

となっております。


プログラムを起動させると，まずこのファイルを読み込んで表を作ります。

できる操作は以下の通りです。

(R1) 全都道府県のデータを列挙する。(操作 1)

(R2)「都道府県名 (英)」および「都道府県庁所在地 (英)」のいずれを用いても，該当する都道府県のデータを,高々O(log n) の平均時間計算量で探索する。(操作 2，操作 3)

(R3)「人口」および「面積」のランキングを表示する。(操作 4，操作 5)

(R4)「都道府県名 (英)」を指定して，当該都道府県の「人口」データを修正できる。(操作 6)

(R5) データファイルをリロード (再読み込み) できる。(操作 7)

(R6) 修正された (人口) データをデータファイルに上書きできる。(操作 8)

(R7) 起動直後にデータファイルを読み込み，操作 1～9 の選択待ち受け状態となるメニュー画面を表示する。

(R8) 操作 1～8 を実行した直後，メニュー画面を表示する。

(R9) メニュー画面からプログラムを終了させる。(操作 9)
