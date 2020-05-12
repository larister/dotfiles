const { execSync } = require('child_process');

const jiraRegex = /\w+-\d+/;

try {
    const branchName = execSync('git rev-parse --abbrev-ref HEAD').toString();

    const ticket = jiraRegex.exec(branchName);

    if (ticket) {
        execSync(`open https://office.brandwatch.com/jira/browse/${ticket[0]}`);
    } else {
        console.error('No ticket found');
    }
} catch(e) {
    console.error('Cannot open JIRA ticket as no git branch found');
}

