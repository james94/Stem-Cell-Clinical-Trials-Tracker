import React from 'react';
import { Link } from 'react-router-dom';
import { fetchMyPWatchlist } from '../utils';
// import PatientWatchlistService from '../service/PatientWatchlistService';
import { PWATCHLISTS_API_BASE_URL }  from '../settings';

class PatientWatchlistsPage extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            watchlists: [],
            name: "",
            patientId: "000000001",
            diseaseArea: ""
        };
    }

    retrievePWatchlist = (url) => {
        fetchMyPWatchlist(url, null, {method: 'GET'}, null, {'id': localStorage.getItem('id')})
        .then(data => {
            console.log(data)
            this.setState({
                watchlists: data
            });
        })
        .catch(err => {
            console.log(err)
        })
    }

    // retrievePWatchlist = () => {
    //     let config = {
    //         headers: {
    //             'id': '000000001'
    //         }
    //     };
    //     PatientWatchlistService.getPatientWatchlistById(config)
    //     .then(data => {
    //         console.log(data)
    //         this.setState({
    //             watchlists: data
    //         });
    //     })
    //     .catch(err => {
    //         console.log(err)
    //     })
    // }

    componentDidMount() {
        console.log("Rendering Patient Watchlist");

        // show patient watchlist
        this.retrievePWatchlist(PWATCHLISTS_API_BASE_URL);

        // this.retrievePWatchlist();
    }

    render() {
        return (
            <div>
                <h1>Patient's Watchlist</h1>
                <ul>
                    {this.state.watchlists.map((e,i) => <li key={i}>
                        <Link to={{pathname:'/trials', state:{disease: e.diseaseArea}}} >{e.name}</Link>   
                    </li>)}
                </ul>
            </div>
        )
    }

}

export default PatientWatchlistsPage;
