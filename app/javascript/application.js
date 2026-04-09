// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//画面が読み込まれたら以下の処理を実行する
document.addEventListener("turbo:load", function() {
   //.user-menuをjsで扱う用のuserMenuと名付ける
  const userMenu = document.querySelector(".user-menu");
  //.pulldownも同様
  const pulldown = document.querySelector(".pulldown");

  //画面に2つの要素があるとき(ログインしているとき)
  if (userMenu && pulldown) {
    //userMenuがクリックされたら以下の処理を実行する
    userMenu.addEventListener("click",function() {
    //cssで設定したactiveがついたり消えたりする
      pulldown.classList.toggle("active");
    });

    //画面がクリックされたら以下の処理を実行する
    document.addEventListener("click", function(event) {
      //クリックされた場所がuserMenuの箱の外なら（event.targetはクリックされた場所を特定する）
      if (!userMenu.contains(event.target)) {
        //activeクラスを消してメニューを閉じる
        pulldown.classList.remove("active");
      }
    });
  }
});

window.toggleMenu = function(element) {
  //クリックされた三点リーダーの隣にあるメニューを探す
  const dropdown = element.nextElementSibling;
  
  //他に開いているメニューがあれば全部閉じる
  document.querySelectorAll('.room-dropdown').forEach(menu => {
    if (menu !== dropdown) menu.classList.remove('show');
  });

  //今のメニューの表示・非表示を切り替える
  dropdown.classList.toggle('show');
};

//画面のどこかをクリックした時にメニューを閉じる
window.addEventListener('click', function(e) {
  if (!e.target.matches('.menu-dots')) {
    document.querySelectorAll('.room-dropdown').forEach(menu => {
      menu.classList.remove('show');
    });
  }
});
