#!/usr/bin/env node

/**
 * Pipe outputof `upower --dump`:
 * 
 * upower --dump | mouse-battery.mjs
 * 
 * Get formatted mouse battery level and charging status
 */

const readStdin = () =>
    new Promise((resolve) => {
        let str = '';
        process.stdin.on('data', (next) => { str += next.toString(); });
        process.stdin.on('error', () => resolve(''));
        process.stdin.on('end', () => resolve(str));
    });

(async () => {
    const stdin = await readStdin();

    const groups = stdin.split('\n\n');
    const mouseGroup = groups.find((group) => /model:\s+Gaming Mouse/.test(group));

    if (!mouseGroup) {
        return;
    }

    const [, percentage] = mouseGroup.match(/percentage:\s+(\d+%)/) ?? [, '???'];
    const charging = /state:\s+charging/.test(mouseGroup);

    console.log(`🖱 ${charging ? 'CH:' : ''}${percentage}`);
})();