// SJSU CMPE 138 Fall 2021 TEAM1
import { Button } from "semantic-ui-react";
import { Link } from "react-router-dom";

const Top = () => {
    return (
        <div style={{ margin: "10px auto 20px 10px" }}>
            <Link to={localStorage.getItem('role') === 'researcher' ? '/rhome' : '/phome'}>
                <Button>Home</Button>
            </Link>
        </div>
    );
}

export default Top;
