import { Button } from "semantic-ui-react";
import {Link} from "react-router-dom";

const Top = () => {
    return (
        <div style={{margin: "10px auto 20px 10px"}}><Button><Link to={localStorage.getItem('role') === 'researcher' ? '/rhome' : '/phome'}>Home</Link></Button></div>
    );
}

export default Top;