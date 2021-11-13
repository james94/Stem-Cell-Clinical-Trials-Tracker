import React from 'react';
import { Link } from 'react-router-dom';
import { fetchMyPWatchlist } from '../utils';
import { fetchMytrial } from '../utils';
// import PatientWatchlistService from '../service/PatientWatchlistService';
import { PWATCHLISTS_API_BASE_URL, ADD_P_WATCHLIST_END_POINT }  from '../settings';
import { Button, Modal, Form, Dropdown } from 'semantic-ui-react';

const diseaseOptions = [
    {
        key: 'Age-related macular degeneration',
        text: 'Age-related macular degeneration',
        value: 'Age-related macular degeneration'
    },
    {
        key: 'Blood Cancer',
        text: 'Blood Cancer',
        value: 'Blood Cancer'
    },
    {
        key: 'Corneal Damage',
        text: 'Corneal Damage',
        value: 'Corneal Damage'
    },
    {
        key: 'Spinal Cord Injury',
        text: 'Spinal Cord Injury',
        value: 'Spinal Cord Injury'
    }
];

const WatchlistForm = (props) => {
    return (
        <Form>
            <Form.Field>
                <label>Watchlist Name</label>
                <input placeholder='name' onChange={e => {props.setWatchlistName(e.target.value)}} />
            </Form.Field>
            <Form.Field>
                <label>Disease Area</label>
                <Dropdown
                    placeholder='Select Disease'
                    fluid
                    selection
                    options={diseaseOptions}
                    value={props.disease}
                    onChange={(_, obj) => {props.setDiseaseInForm(obj.value)}}
                />

            </Form.Field>
        </Form>)
}

class PatientWatchlistsPage extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            watchlists: [],
            name: "",
            patientId: "000000001",
            diseaseArea: "",
            modalOpen: false,
            watchListName: null,
            diseaseInForm: null
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

    setOpen = (open) => {
        this.setState({
            modalOpen: open
        });
    }

    setWatchlistName = (name) => {
        this.setState({
            watchListName: name
        });
    }

    setDiseaseInForm = (disease) => {
        this.setState({
            diseaseInForm: disease
        });
    }

    addWatchlist = (watchlistName, disease) => {
        if (watchlistName !== null && disease !== null) {
            fetchMytrial(ADD_P_WATCHLIST_END_POINT, null, {method: 'POST'}, {name: watchlistName, diseaseArea: disease}, {id: localStorage.getItem('id')})
            .then(d => {
                this.setOpen(false);
                this.retrievePWatchlist(PWATCHLISTS_API_BASE_URL);
            })
            .catch(err => {
                console.log(err)
            })
        } else {
            alert('Please fill all fields');
        }
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
                <Modal
                 onClose={() => this.setOpen(false)}
                 onOpen={() => this.setOpen(true)}
                 open={this.state.modalOpen}
                 trigger={<Button style={{marginLeft: "10px"}}>Add Watchlist</Button>}
                >
                    <Modal.Header>Create a New Watchlist</Modal.Header>
                    <Modal.Content>
                        <Modal.Description>
                            <WatchlistForm name={this.state.watchListName} disease={this.state.diseaseInForm} setWatchlistName={this.setWatchlistName} setDiseaseInForm={this.setDiseaseInForm}/>
                        </Modal.Description>
                    </Modal.Content>
                    <Modal.Actions>
                        <Button
                        content="Submit"
                        labelPosition='right'
                        icon='checkmark'
                        onClick={() => {  
                            this.addWatchlist(this.state.watchListName, this.state.diseaseInForm);
                        }}
                        positive
                        />
                    </Modal.Actions>
                </Modal>
            </div>
        )
    }

}

export default PatientWatchlistsPage;
