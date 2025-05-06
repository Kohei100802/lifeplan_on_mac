from flask import Flask, render_template_string

app = Flask(__name__)

@app.route('/')
def index():
    html = '''
    <!DOCTYPE html>
    <html lang="ja">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ライフプランシミュレーター</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                text-align: center;
            }
            .features {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                margin-top: 30px;
            }
            .feature {
                flex-basis: 30%;
                background-color: #f9f9f9;
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            @media (max-width: 768px) {
                .feature {
                    flex-basis: 100%;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>ライフプランシミュレーター</h1>
            <p>
                ライフプランシミュレーターへようこそ。このアプリはあなたの将来の資産と生活をシミュレーションして、人生設計をサポートします。
            </p>
            
            <div class="features">
                <div class="feature">
                    <h3>将来の資産を見える化</h3>
                    <p>収入と支出のバランスを分析し、将来の資産残高をグラフで表示します。</p>
                </div>
                <div class="feature">
                    <h3>ライフイベントを考慮</h3>
                    <p>結婚、出産、住宅購入など、人生の重要なイベントを考慮したシミュレーションが可能です。</p>
                </div>
                <div class="feature">
                    <h3>データのエクスポート</h3>
                    <p>シミュレーション結果をCSVやJSONで出力して、他のツールでも活用できます。</p>
                </div>
            </div>
            
            <p style="text-align: center; margin-top: 30px;">
                アプリが正常に起動しました！
            </p>
        </div>
    </body>
    </html>
    '''
    return render_template_string(html)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)