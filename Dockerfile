FROM node:20-slim

WORKDIR /app

COPY package*.json ./
RUN node -e "const fs=require('fs');const p='package.json';let b=fs.readFileSync(p);let s=b.includes(0)?b.toString('utf16le'):b.toString('utf8');s=s.replace(/^\uFEFF/,'');fs.writeFileSync(p,s,{encoding:'utf8'})" && npm install --omit=dev --no-audit --no-fund

COPY . .
RUN node -e "const fs=require('fs');for (const p of ['index.js','bootstrap.js']) { if (!fs.existsSync(p)) continue; let b=fs.readFileSync(p); let s=b.includes(0)?b.toString('utf16le'):b.toString('utf8'); s=s.replace(/^\uFEFF/,''); fs.writeFileSync(p,s,{encoding:'utf8'}); }"

ENV NODE_ENV=production
EXPOSE 10000

CMD ["npm", "start"]
