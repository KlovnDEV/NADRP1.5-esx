import React from 'react';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';
import Alert from '@material-ui/lab/Alert';
import { makeStyles } from '@material-ui/core/styles';
import { blue, red, green } from '@material-ui/core/colors';
import { createMuiTheme, ThemeProvider  } from '@material-ui/core/styles';
import Fade from '@material-ui/core/Fade';
function SnackAlert(props) {
    return <MuiAlert elevation={6} variant="filled" {...props} />;
}

const useStyles = makeStyles((theme) => ({
    root: {
      width: '13%',
      maxWidth: '18%',
      position: 'relative',
      marginTop: '20%',
      marginLeft: '5px',
      '& > * + *': {
        marginTop: theme.spacing(1),
      },
    },
}));

const theme = createMuiTheme({
    palette: {
        info: {
            main: blue[900]
        },
        error: {
            main: red[900]
        },
        success: {
            main: green[900]
        }
    }
})

function Alerts() {
    const classes = useStyles()
    const [SnackData, setSnackData] = React.useState({open: false,type: "error",text: "No Text",duration: 6000})
    const [GrowData, setGrow] = React.useState({ open: false, type: "error", text: "No Text"})

    const handleClose = (event, reason) => {
        if (reason === 'clickaway') {
            return;
        }
        setSnackData({
            ...SnackData,
            open: false
        })
    };
    const handleGrowClose = (event, reason) => {
        if (reason === 'clickaway') {
            return;
        }
        setGrow({
            ...GrowData,
            open: false
        })
    };

    function ShowAlert(data) {
        if (!SnackData.open === true) {
            setSnackData({
                open: true,
                type: data.type,
                text: data.text,
                duration: parseInt(data.duration),
            })
        }
    }

    function persistAlert(data) {
        if (!GrowData.open) {
            if (data.show == "show") {
                setGrow({
                    open: true,
                    type: data.type,
                    text: data.text,
                })
            } else if (data.show == "hide") {
                setGrow({
                    open: false,
                    type: data.type,
                    text: data.text,
                })
            }
        }
    }

    const makeEvent = () => {
        window.addEventListener('message', function(event) {
            let data = event.data
            if (data.event == "ShowAlert") {
                ShowAlert(data)
            } else if (data.event == "persistAlert") {
                if (data.show !== undefined) {
                    persistAlert(data)
                }
            }
        })
    }

    document.onreadystatechange = function () {
        if (document.readyState === 'complete') {
            makeEvent();
        }
    }

    return (
        <div>
            <ThemeProvider theme={theme}>
                <Snackbar className="snackBar"
                    open={SnackData.open}
                    key={SnackData.text}
                    autoHideDuration={SnackData.duration}
                    onClose={handleClose}
                    anchorOrigin={{vertical: 'top', horizontal: 'center'}}>
                    <SnackAlert 
                        classes={{ action: "action"}}
                        severity={SnackData.type}>
                        {SnackData.text}
                    </SnackAlert>
                </Snackbar>
                <div className={classes.root}>
                    <div className="alert">
                        <Fade in={GrowData.open}>
                            <Alert
                                style={{
                                    fontWeight: '600'
                                }}
                                icon={false}
                                classes={{action: "action"}}
                                severity={GrowData.type}
                                variant="filled">
                                {GrowData.text}
                            </Alert>
                        </Fade>
                    </div>
                </div>
            </ThemeProvider>
        </div>
    );
}

export default Alerts;