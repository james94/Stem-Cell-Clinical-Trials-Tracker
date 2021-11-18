// SJSU CMPE 138 Fall 2021 TEAM1
import React from 'react';
// import { Link } from 'react-router-dom';
import UnauthorizedPage from './UnauthorizedPage';
import axios from "axios";
import { PATIENTS_ALL_BASE_URL } from "../settings/";
// import { Selection, IColumn } from '@fluentui/react/lib/DetailsList';
import { DetailsList, DetailsListLayoutMode } from '@fluentui/react/lib/DetailsList';
// import { ITextFieldStyles } from '@fluentui/react/lib/TextField';
import { TextField } from '@fluentui/react/lib/TextField';

//TODO: Maybe add pagination to make list more readable.
const comboBoxStyles = { root: { margin:'10px', maxWidth: 300 } };
class SearchPage extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            searchTerm: "",
            items: [],
            response: [],
            role: localStorage.getItem('role'),
            researcher_id: localStorage.getItem('id')
        };

        // This binding is necessary to make `this` work in the callback
        this.handleSubmit = this.handleSubmit.bind(this);
        this.handleChange = this.handleChange.bind(this);
    }

    getData = () => {
        let config = {
          headers: {
              researcher_id: this.state.researcher_id,
              search: true
          }
        };
        axios
          .get(PATIENTS_ALL_BASE_URL, config)
          .then((response) => {
            const filteredItems = response.data.map(x=>{
                return {
                    key: x.patient_id,
                    pid: x.patient_id,
                    dname: x.disease,
                    pname: x.p_username,
                    researcher: x.researcher
                }
            })

            this.setState({
              data: filteredItems,
              items: filteredItems,
            });
          })
          .catch((error) => {
            console.log(error);
          });
      };

      componentDidMount() {
        this.getData();
      }

    handleSubmit(e) {
        e.preventDefault();

        this.setState({ searchTerm: e.target.elements.search.value });

    }

    handleChange(e) {
        e.preventDefault();
        console.log('You are typing.');
        let text = e.target.value;
        let _data = this.state.data;
        this.setState({
            items: text ? _data.filter(i => i.dname.toLowerCase().indexOf(text.toLowerCase()) > -1) : _data,
        });

    }


    render() {

        const role = this.state.role;
        this._columns = [
            { key: '', name: 'Disease Name', fieldName: 'dname', minWidth: 100, maxWidth: 200, isResizable: true },
            { key: '', name: 'Patient ID', fieldName: 'pid', minWidth: 100, maxWidth: 200, isResizable: true },
            { key: '', name: 'Patient User Name', fieldName: 'pname', minWidth: 100, maxWidth: 200, isResizable: true },
        ];
        console.log(role);
        if (role == "patient") {
            return <UnauthorizedPage />
        }
        else if (role == "researcher") {
            return (
                <div>
                    <div>
                        <TextField
                            label="Search"
                            onChange={this.handleChange}
                            styles={comboBoxStyles}
                        />
                    </div>

                    <div className="resultsDiv">
                        <DetailsList
                            items={this.state.items}
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

export default SearchPage;
