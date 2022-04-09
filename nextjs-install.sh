#!/bin/bash

echo "NextJS install"

# Instructions:
echo
echo "Currently, you need NodeJS and Yarn installed on your machine."
echo
echo "This will create a folder on $PWD"

echo
read -p 'App slug (i.e. "facebook"): ' appslug
rm -rf $PWD/$appslug
mkdir -p $PWD/$appslug
echo $PWD/$PWD/$appslug

cd $PWD/$appslug

# create the readme file
echo "1. README.md"
echo "# $appslug" >> README.md

# initialize monorepo and gitignore
echo "2. Initializing monorepo"
mkdir packages
npx gitignore node
cat << EOF > package.json
{
  "private": true,
  "workspaces": ["packages/*"],
  "scripts": {
    "dev": "yarn workspace $appslug dev"
  }
}
EOF

# create next-app (TS)
echo "3. Installing NextJS"
# output is supressed here, but no errors
yarn create next-app --typescript packages/$appslug > /dev/null

### customize next-app create ###
echo "4. Customizing NextJS"
cd packages/$appslug

# remove API folder
echo "4.1. Remove API folder"
rm -rf pages/api

# remove CSS module approach
echo "4.2. Remove CSS modules"
rm -rf styles

# overwrite index.tsx
echo "4.3. overwrite index.tsx"
cat << EOF > pages/index.tsx
import type { NextPage } from 'next'
import Head from 'next/head'

const Home: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Application</title>
        <meta name="description" content="Application" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>MAIN</main>

      <footer>FOOTER</footer>
    </div>
  )
}

export default Home

EOF

# overwrite _app.tsx
echo "4.4. overwrite _app.tsx"
cat << EOF > pages/_app.tsx
import type { AppProps } from 'next/app'

function MyApp({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}

export default MyApp

EOF

# add styled-components
echo "4.5. add styled-components"
yarn add @types/styled-components styled-components
node -e "const { readFileSync, writeFileSync } = require('fs');\
const lines = readFileSync('next.config.js', 'utf8').split('\n');\
const nextConfigLineIndex = lines.findIndex((line) => line.match(/const nextConfig = {/i));\
const styledComponentsString = '  compiler: { styledComponents: true },';\
lines.splice(nextConfigLineIndex + 1, 0, styledComponentsString);\
const content = lines.join('\\n');\
writeFileSync('next.config.js', content);\
"

# create "initial commit"
echo "5. Initial commit"
git init
git add .
git commit -m "Initial commit"

echo 
echo "Excited to start?"
echo 
echo "Just cd $appslug and run \"yarn dev\"! 🎉"

echo "All done. Bye 👋🏻"
