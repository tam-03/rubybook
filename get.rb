require "net/http"
require "uri"
uri = URI.parse("https://example.com/")
puts Net::HTTP.get(uri)


```ruby

親クラス、子クラスともいい、親クラスで定義したメソッドを子クラスでも使う事が出来る
継承
class クラス名 < スーパークラス名
end

どんなクラスの継承が行われているのか
クラス名.ancestors

p Integer.ancestors
# => [Integer, Numeric, Comparble, Object, Kernel, BasicObject]

=begin
親子のクラスで同名メソッドを定義したの場合は、最初に該当したクラスのメソッドが使われる
#オブジェクトa.同名のメソッド←これが親だろうが子だろうが使ったオブジェクトのクラスに定義された方を使う

いつどのタイミングで使うかは分からないが、superを定義すると親の方を使う様になる
=end

親クラスと同名のメソッドを定義
super

#privateなメソッド
private　　　　#←これ以降、定義するメソッドをプライベートなメソッドにする
    def メソッド
    end

private def メソッド #これだけprivateなメソッドに出来る
end

#「モジュール」メソッドを共同利用する為の部品
module モジュール名
end

対象のクラスにincludeで使う(インスタンスメソッド)
対象のクラスにextendで使う(クラスメソッド)

#別ファイルから読み込み
require_relative "ファイル名"

```

Rubyの3つのライブラリ
- 組み込みライブラリ
- 標準添付ライブラリ
- インストールするGemライブラリ

Gem
プログラムのライブラリ

Gemのインストール
`$ gem install Gem名`

複数のGemを管理する"Bundler"

Sinatra
Ruby製の軽量で動くオープンソースWebアプリケーションフレームワーク


こんなエラーが

```bash

.rbenv/versions/2.7.1/lib/ruby/gems/2.7.0/gems/awesome_print-1.8.0/lib/awesome_print/formatters/
base_formatter.rb:113: warning: Capturing the given block using Proc.new is deprecated; use `&block` instead

```

