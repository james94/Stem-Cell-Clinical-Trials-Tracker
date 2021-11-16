import {
    ComboBox,
    PrimaryButton
} from '@fluentui/react';
import React from 'react';
import UnauthorizedPage from './UnauthorizedPage';
import { DetailsList, DetailsListLayoutMode, Selection, IColumn } from '@fluentui/react/lib/DetailsList';
import axios from "axios";
import { RWATCHLISTS_API_BASE_URL, ADD_R_WATCHLIST_END_POINT } from "../settings/";

const comboBoxStyles = { root: { maxWidth: 300 } };
const buttonStyles = { root: { display: 'block', margin: '10px 0 20px' } };

//TODO: get disease options from DB 
//TODO: maybe make list more readable 
class DiseaseWatchListPage extends React.Component {

    constructor(props) {
        super(props);
        const _options = [
            { key: 'A', text: 'Brain Cancer' },
            { key: 'B', text: 'Cancer' },
            { key: 'C', text: 'Solid Tumors' },
            { key: 'D', text: 'Acute Myeloid Leukemia' },
        ];

        this.state = {
            researcherName: "",
            disease: "",
            watchlists: [],
            filteredData: [],
            options: _options,
            role: localStorage.getItem('role'),
            researcher_id: localStorage.getItem('id')
        };

        // This binding is necessary to make `this` work in the callback
        this.handleButtonSubmit = this.handleButtonSubmit.bind(this);
        this.handleDiseaseClick = this.handleDiseaseClick.bind(this);
    }

    //gets data from r_watchlist where researh_id = current researcher id
    getData = () => {
        let config = {
            headers: {
                id: this.state.researcher_id
            }
        };
        axios
            .get(RWATCHLISTS_API_BASE_URL, config)
            .then(response => {
                const filteredItems = response.data.map(x => {
                    return {
                        key: x.pid,
                        rid: x.researcherId,
                        darea: x.diseaseArea,
                        rname: x.name,
                        pusername: x.pusername,
                        pid: x.pid
                    }
                });


                console.log(filteredItems);
                this.setState({
                    watchlists: filteredItems,
                    researcherName: filteredItems[0].rname
                });
            })
            .catch(err => {
                console.log(err)
            })
    }

    componentDidMount() {
        this.getData();
    }

    handleButtonSubmit(e) {
        e.preventDefault();
        debugger;
        this.addToWatchlist(this.state.disease);

    }

    addToWatchlist = (disease) => {
        let config = {
            headers: {
                id: this.state.researcher_id
            }
        };
        let body = { name: this.state.researcherName, diseaseArea: disease }

        if (disease !== null) {

            axios
                .post(ADD_R_WATCHLIST_END_POINT, body, config)
                .then(d => {
                    this.setOpen(false);
                    this.retrievePWatchlist(RWATCHLISTS_API_BASE_URL);
                })
                .catch(err => {
                    console.log(err)
                })
        } else {
            alert('Please fill all fields');
        }
    }

    handleDiseaseClick(e, selectedOption) {
        console.log(selectedOption);
        this.setState({
            disease: selectedOption
        });
    }

    render() {
        this.getData();
        const role = this.state.role;
        this._columns = [
            { key: 'darea', name: 'Disease Name', fieldName: 'darea', minWidth: 100, maxWidth: 200, isResizable: true },
            { key: 'pid', name: 'Patient ID', fieldName: 'pid', minWidth: 100, maxWidth: 200, isResizable: true },
            { key: 'pusername', name: 'Patient Name', fieldName: 'pusername', minWidth: 100, maxWidth: 200, isResizable: true },
        ];


        if (role == "patient") {
            return <UnauthorizedPage />
        }
        else if (role == "researcher") {
            return (
                <div style={{ margin: '10px' }}>
                    <div>
                        <ComboBox
                            defaultSelectedKey="C"
                            label="Choose disease"
                            options={this.state.options}
                            styles={comboBoxStyles}
                            onItemClick={(e, selectedOption) => {
                                console.log(selectedOption.text);
                                this.setState({
                                    disease: selectedOption.text
                                });
                            }}
                        />
                        <PrimaryButton
                            text="Add to watchlist"
                            onClick={this.handleSubmit}
                            styles={buttonStyles}
                            onClick={this.handleButtonSubmit}
                        />
                    </div>
                    <div>
                        <h3>{this.state.researcherName}'s Disease Watchlist</h3>
                    </div>
                    {/* <div>
                        <FocusZone>
                            <SelectionZone selection={selection} selectionMode={SelectionMode.multiple}>
                                <GroupedList
                                    items={this.state.watchlists}
                                    onRenderCell={onRenderCell}
                                    groups={groups}
                                    groupProps={groupProps}
                                />
                            </SelectionZone>
                        </FocusZone>
                    </div> */}
                    <div>
                        <DetailsList
                            items={this.state.watchlists}
                            columns={this._columns}
                            setKey="set"
                            layoutMode={DetailsListLayoutMode.justified}
                        />
                    </div> 
                </div>


            );
        }

    }

}

export default DiseaseWatchListPage;