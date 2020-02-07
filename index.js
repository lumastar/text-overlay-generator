const express = require('express')
const bodyParser = require('body-parser')
const spawn = require('await-spawn')

const app = express()
const port = 3000

app.use(bodyParser.json())
app.use(express.static('public'))

app.post('/generate', async (req, res) => {
    const line1 = req.body.line1 || ''
    const line2 = req.body.line2 || ''

    if (line1.length === 0 && line2.length === 0) {
        res.status(422).send('text too short')
    } else {
        try {
            console.log(`running generate with "${line1}"-"${line2}"`)
            const r = await spawn('./generate.sh', [ line1, line2 ])
            console.log('generated', r)
            res.send('done')
        } catch (e) {
            console.log('generate failed: ', e.stderr.toString())
            res.status(500).send('failed to generate')
        }
    }
})

app.post('/upload', async (req, res) => {
    try {
        console.log(`running upload`)
        const r = await spawn('./upload.sh')
        console.log('uploaded', r)
        res.send('done')
    } catch (e) {
        console.log('upload failed: ', e.stderr.toString())
        res.status(500).send('failed to generate')
    }
})

app.listen(port, () => console.log(`Text generator app listening on port ${port}!`))
