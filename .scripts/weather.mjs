#!/usr/bin/env node

/**
 * Pipe weather data:
 * 
 * waybar:
 * curl -s 'https://wttr.in/?format=j1' | weather.mjs 
 * 
 * polybar:
 * curl -s 'https://wttr.in/?format=j1' | weather.mjs simple
 * 
 * Get formatted status bar weather
 */

const todayD = new Date();
const tomorrowD = new Date();
tomorrowD.setDate(tomorrowD.getDate() + 1);

const CURRENT_HOUR = todayD.getHours();

const TODAY = new Date().toISOString().slice(0, 10);

const TOMORROW = tomorrowD.toISOString().slice(0, 10);

const NAMED_DATES = {
    [TODAY]: 'Today',
    [TOMORROW]: 'Tomorrow'
};

const WEATHER_ICONS = {
    '113': '☀️',
    '116': '⛅️',
    '119': '☁️',
    '122': '☁️',
    '143': '🌫',
    '176': '🌦',
    '179': '🌧',
    '182': '🌧',
    '185': '🌧',
    '200': '⛈',
    '227': '🌨',
    '230': '❄️',
    '248': '🌫',
    '260': '🌫',
    '263': '🌦',
    '266': '🌦',
    '281': '🌧',
    '284': '🌧',
    '293': '🌦',
    '296': '🌦',
    '299': '🌧',
    '302': '🌧',
    '305': '🌧',
    '308': '🌧',
    '311': '🌧',
    '314': '🌧',
    '317': '🌧',
    '320': '🌨',
    '323': '🌨',
    '326': '🌨',
    '329': '❄️',
    '332': '❄️',
    '335': '❄️',
    '338': '❄️',
    '350': '🌧',
    '353': '🌦',
    '356': '🌧',
    '359': '🌧',
    '362': '🌧',
    '365': '🌧',
    '368': '🌨',
    '371': '❄️',
    '374': '🌧',
    '377': '🌧',
    '386': '⛈',
    '389': '🌩',
    '392': '⛈',
    '395': '❄️'
};

const WIND_ICONS = {
    'NW': '↖',
    'N': '↑',
    'NE': '↗',
    'E': '→',
    'SE': '↘',
    'S': '↓',
    'SW': '↙',
    'W': '←'
};

const normalizeValues = (obj) => {
    return Object.fromEntries(
        Object.entries(obj).map(([key, val]) => {
            // snake to camel case keys
            const newKey = key[0].toLowerCase() + 
                key.slice(1)
                    .replace(
                        /_(\w)([^_]*)/g,
                        (_, first, rest) => first.toUpperCase() + (rest ?? '')
                    );

            // convert { value: '...' } objects into plain '...'
            const newVal = Array.isArray(val)
                ? val.map((v) => v?.value ?? normalizeValues(v))
                : typeof val === 'object' ? normalizeValues(val) : val;
            
            return [newKey, newVal];
        })
    );
};

const readJSON = async () => {
    try {
        const data = await new Promise((resolve) => {
            let str = '';
            process.stdin.on('data', (next) => { str += next.toString(); });
            process.stdin.on('end', () => resolve(str));
        });
        return normalizeValues(JSON.parse(data));
    } catch (e) {
        console.error('Bad data');
        process.exit(1);
    }
};

(async () => {
    const {
        currentCondition: [now],
        nearestArea: [area],
        weather
    } = await readJSON();

    const simple = `${WEATHER_ICONS[now.weatherCode]} ${now.tempF}°F(${now.feelsLikeF}°F)`;

    if (process.argv[2] === 'simple') {
        console.log(simple);
        return;
    }

    const details = weather
        .map(({ date, hourly, maxtempF, mintempF }) => {
            if (date < TODAY || (date === TODAY && CURRENT_HOUR >= 21)) { 
                return '';
            }
            const hourlyData = hourly.map((hour) => {
                const hourLabel = ` ${(hour.time / 100).toString().padStart(2, '0')}:`;
                if (date === TODAY && (hour.time / 100) <= CURRENT_HOUR) {
                    const blank = '    ';
                    return { hourLabel, icon: blank, tempF: blank, precipChance: blank };
                }
                const icon = `${WEATHER_ICONS[hour.weatherCode]} `;
                const tempF = `${hour.tempF}°`.padStart(4);
                const precipChance = `${Math.max(
                    ...[
                        hour.chanceofrain,
                        hour.chanceofsnow
                    ].map((s) => Number(s))
                )}%`.padStart(4);
                return { hourLabel, icon, tempF, precipChance };
            });

            return `
<b>${NAMED_DATES[date] ?? date}</b> - <b>${maxtempF}°F / ${mintempF}°F</b>
<u><i>${hourlyData.map(({ hourLabel }) => hourLabel).join('')}</i></u>
${hourlyData.map(({ tempF }) => tempF).join('')}
${hourlyData.map(({ precipChance }) => precipChance).join('')}
${hourlyData.map(({ icon }) => icon).join('')}
            `.trim();
        })
        .join('\n\n').trim();
       
    const result = {
        text: simple,
        tooltip: `
<b>${area.areaName}, ${area.region}</b> 

${now.tempF}°F / ${now.tempC}°C (${now.feelsLikeF}°F / ${now.feelsLikeC}°C)
${now.weatherDesc}

<b>Wind:</b> ${WIND_ICONS[now.winddir16Point.slice(-2)]} ${now.windspeedMiles} mph (${now.windspeedKmph} Km/h)
<b>Humidity:</b> ${now.humidity}%
<b>Precipitation:</b> ${now.precipInches}" (${now.precipMM}mm)

${details}
        `.trim()
    };

    if (process.argv[2] === 'detailed') {
        console.log(result.tooltip);
        return;
    }

    console.log(JSON.stringify(result));
})();