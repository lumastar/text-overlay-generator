const express = require('express')
const bodyParser = require('body-parser')
const spawn = require('await-spawn')

const app = express()
const port = 3000

app.use(bodyParser.json())
app.use(express.static('public'))

app.post('/generate', async (req, res) => {
    const txt = req.body.content || ''

    if (txt.length === 0) {
        res.status(422).send('text too short')
    } else {
        try {
            console.log(`running generate with "${txt}"`)
            await spawn('./generate.sh', [ txt ])
            res.send('done')
        } catch (e) {
            res.send('failed to generate')
        }
    }
})

app.listen(port, () => console.log(`Text generator app listening on port ${port}!`))
